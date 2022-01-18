# ViewComponent::Form

**ViewComponent::Form** provides a `FormBuilder` with the same interface as [`ActionView::Helpers::FormBuilder`](https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html), but using [ViewComponent](https://github.com/github/view_component)s for rendering the fields. It's a starting point for writing your own custom ViewComponents.

:warning: **This is an early release: the API is subject to change until we reach `v1.0.0`.**

## Compatibility

This gem is tested on:
- Rails 6.0+
- Ruby 2.7+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'view_component-form'
```

And then execute:

    $ bundle install

## Usage

Add a `builder` param to your `form_for`, `form_with`, `fields_for` or `fields`:

```diff
- <%= form_for @user do |f| %>
+ <%= form_for @user, builder: ViewComponent::Form::Builder do |f| %>
```

You can also define a default FormBuilder at the controller level using [default_form_builder](https://api.rubyonrails.org/classes/ActionController/FormBuilder.html#method-i-default_form_builder).

Then call your helpers as usual:

```erb
<%# app/views/users/_form.html.erb %>
<%= form_for @user, builder: ViewComponent::Form::Builder do |f| %>
  <%= f.label :first_name %>        <%# renders a ViewComponent::Form::LabelComponent %>
  <%= f.text_field :first_name %>   <%# renders a ViewComponent::Form::TextFieldComponent %>

  <%= f.label :last_name %>         <%# renders a ViewComponent::Form::LabelComponent %>
  <%= f.text_field :last_name %>    <%# renders a ViewComponent::Form::TextFieldComponent %>

  <%= f.label :email %>             <%# renders a ViewComponent::Form::LabelComponent %>
  <%= f.email_field :email %>       <%# renders a ViewComponent::Form::EmailFieldComponent %>

  <%= f.label :password %>          <%# renders a ViewComponent::Form::LabelComponent %>
  <%= f.password_field :password, aria: { describedby: f.field_id(:password, :description) } %>
                                    <%# renders a ViewComponent::Form::PasswordFieldComponent %>
                                    <%# Note: #field_id only supported on Rails 7 %>
  <div id="<%= f.field_id(:title, :description) %>">
    <%= f.hint :password, 'The password should be at least 8 characters long' %>
                                      <%# renders a ViewComponent::Form::HintComponent %>
    <%= f.error_message :password %>  <%# renders a ViewComponent::Form::ErrorMessageComponent %>
  </div>
<% end %>
```

It should work out of the box, but does nothing particularly interesting for now.

```html
<form class="edit_user" id="edit_user_1" action="/users/1" accept-charset="UTF-8" method="post">
  <input type="hidden" name="_method" value="patch" />
  <input type="hidden" name="authenticity_token" value="[...]" />

  <label for="user_first_name">First name</label>
  <input type="text" value="John" name="user[first_name]" id="user_first_name" />

  <label for="user_last_name">Last name</label>
  <input type="text" value="Doe" name="user[last_name]" id="user_last_name" />

  <label for="user_email">E-mail</label>
  <input type="email" value="john.doe@example.com" name="user[email]" id="user_email" />

  <label for="user_password">Password</label>
  <input type="password" name="user[password]" id="user_password" aria-describedby="user_password_description" />
  <div id="user_password_description">
    <div>The password should be at least 8 characters long</div>
  </div>
</form>
```

The `ViewComponent::Form::*` components are included in the gem.

### Customizing the `FormBuilder` and the components

First, generate your own `FormBuilder`:

```console
bin/rails generate vcf:builder CustomFormBuilder

      create  lib/custom_form_builder.rb
```

This allows you to pick the namespace your components will be loaded from.

```rb
# lib/custom_form_builder.rb
class CustomFormBuilder < ViewComponent::Form::Builder
  # Set the namespace you want to use for your own components
  namespace Custom::Form
end
```

Use the generator options to change the default namespace or the path where the file will be created:

```console
bin/rails generate vcf:builder AnotherCustomFormBuilder --namespace AnotherCustom::Form --path app/forms

      create  app/forms/another_custom_form_builder.rb
```

```rb
# app/forms/another_custom_form_builder.rb
class AnotherCustomFormBuilder < ViewComponent::Form::Builder
  # Set the namespace you want to use for your own components
  namespace AnotherCustom::Form
end
```

Now let's generate your own components to customize their rendering. We can use the standard view_component generator:

```console
bin/rails generate component Custom::Form::TextField --inline --parent ViewComponent::Form::TextFieldComponent

      invoke  test_unit
      create  test/components/custom/form/text_field_component_test.rb
      create  app/components/custom/form/text_field_component.rb
```

:warning: The `--parent` option is available since ViewComponent [`v2.41.0`](https://viewcomponent.org/CHANGELOG.html#2410). If you're using a previous version, you can always edit the generated `Custom::Form::CustomTextFieldComponent` class to make it inherit from `ViewComponent::Form::TextFieldComponent`.

Change your forms to use your new builder:

```diff
- <%= form_for @user, builder: ViewComponent::Form::Builder do |f| %>
+ <%= form_for @user, builder: CustomFormBuilder do |f| %>
```

You can then customize the behavior of your `Custom::Form::CustomTextFieldComponent`:

```rb
# app/components/custom/form/text_field_component.rb

class Admin::Form::TextFieldComponent < ViewComponent::Form::TextFieldComponent
  def html_class
    class_names("custom-text-field", "has-error": method_errors?)
  end
end
```

In this case we leverage the [`#class_names`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-class_names) helper to:
- always add the `custom-text-field` class;
- add the `has-error` class if there is an error on the attribute (using `ViewComponent::Form::FieldComponent#method_errors?`).

The rendered form field will now look like this:

```html
<input class="custom-text-field" type="text" value="John" name="user[first_name]" id="user_first_name">
```

You can use the same approach to inject options, wrap the input in a `<div>`, etc.

We'll add more use cases to the documentation soon.

### Using your form components without a backing model

If you want to ensure that your fields display consistently across your app, you'll need to lean on Rails' own helpers. You may be used to using form tag helpers such as `text_field_tag` to generate tags, or even writing out plain HTML tags. These can't be integrated with a form builder, so they won't offer you the benefits of this gem.

You'll most likely want to use either:

- [`form_with`](https://api.rubyonrails.org/v6.1.4/classes/ActionView/Helpers/FormHelper.html#method-i-form_with) and supply a route as the endpoint, e.g. `form_with url: users_path do |f| ...`, or
- [`fields`](https://api.rubyonrails.org/v6.1.4/classes/ActionView/Helpers/FormHelper.html#method-i-fields), supplying a namespace if necessary. `fields do |f| ...` ought to work in the most basic case.

[`fields_for`](https://api.rubyonrails.org/v6.1.4/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for) may also be of interest. To make consistent use of `view_component-form`, you'll want to be using these three helpers to build your forms wherever possible.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pantographe/view_component-form. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pantographe/view_component-form/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ViewComponent::Form project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pantographe/view_component-form/blob/master/CODE_OF_CONDUCT.md).
