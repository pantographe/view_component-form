# ViewComponent::Form

**ViewComponent::Form** provides a `FormBuilder` with the same interface as [`ActionView::Helpers::FormBuilder`](https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html), but using ViewComponents for rendering the fields. It's a starting point for writing your own custom ViewComponents.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'view_component-form'
```

And then execute:

    $ bundle install

## Usage

Add a `builder` param to your `form_for` of `form_with`:

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
  <%= f.password_field :password %> <%# renders a ViewComponent::Form::PasswordFieldComponent %>
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
  <input type="password" name="user[password]" id="user_password" />
</form>
```

The `ViewComponent::Form::*` components are included in the gem.

### Customizing the `FormBuilder` and the components

:warning: **Everything below this line describes the future usage and is subject to change. It does not work yet as the gem is still under heavy development.**

First, generate your own `FormBuilder`:

```console
bin/rails generate vcf:builder CustomFormBuilder

      create  lib/custom_form_builder.rb
```

This allows you to pick the namespace your components will be loaded from.

```rb
class CustomFormBuilder < ViewComponent::Form::Builder
  # Set the namespace you want to use for your own components
  self.components_namespace = "Form"
end
```

Now let's generate your own components to customize the rendering.

```console
bin/rails generate vcf:component Form::TextField

      invoke  test_unit
      create  test/components/form/text_field_component_test.rb
      create  app/components/form/text_field_component.rb
      create  app/components/form/text_field_component.html.erb
```

Change your forms to use your new builder:

```diff
- <%= form_for @user, builder: ViewComponent::Form::Builder do |f| %>
+ <%= form_for @user, builder: CustomFormBuilder do |f| %>
```

You can then customize the behavior of your `Form::TextFieldComponent`:

```rb
# app/components/form/text_field_component.rb

module Form
  class TextFieldComponent < ViewComponent::Form::TextFieldComponent
    self.tag_klass = ActionView::Helpers::Tags::TextField

    def html_class
      class_names("text-field", "border-error": method_errors?)
    end
  end
end
```

The generated form field with now have your class names:

```html
<input class="text-field" type="text" value="John" name="user[first_name]" id="user_first_name">
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pantographe/view_component-form. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pantographe/view_component-form/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ViewComponent::Form project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pantographe/view_component-form/blob/master/CODE_OF_CONDUCT.md).
