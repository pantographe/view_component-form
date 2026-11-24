# frozen_string_literal: true

module ViewComponent
  module Form
    # @label Text fields
    class TextFieldsPreview < ApplicationPreview
      def text_field
        form { |f| f.text_field :name }
      end

      def text_field_with_value
        form(User.new(name: "Alice")) { |f| f.text_field :name }
      end

      def text_field_with_errors
        form(User.invalid) { |f| f.text_field :name }
      end

      def text_field_with_placeholder
        form { |f| f.text_field :name, placeholder: "Alice" }
      end

      def email_field
        form { |f| f.email_field :email }
      end

      def password_field
        form { |f| f.password_field :password }
      end

      def search_field
        form { |f| f.search_field :name }
      end

      def telephone_field
        form { |f| f.telephone_field :phone }
      end

      def url_field
        form { |f| f.url_field :website }
      end

      def number_field
        form { |f| f.number_field :age, min: 18 }
      end

      def range_field
        form { |f| f.range_field :volume, in: 0..10 }
      end

      def color_field
        form(User.new(favorite_color: "#3b82f6")) { |f| f.color_field :favorite_color }
      end

      def textarea
        form(User.new(bio: "Writes about Ruby.")) { |f| f.textarea :bio, rows: 3 }
      end

      def file_field
        form { |f| f.file_field :avatar, accept: "image/*" }
      end
    end
  end
end
