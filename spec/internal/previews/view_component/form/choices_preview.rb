# frozen_string_literal: true

module ViewComponent
  module Form
    # @label Checkboxes and radio buttons
    class ChoicesPreview < ApplicationPreview
      def checkbox
        form { |f| f.checkbox(:newsletter) + f.label(:newsletter) }
      end

      def radio_button
        form(User.new(role_id: 2)) do |f|
          User::ROLES.sum(ActiveSupport::SafeBuffer.new) do |role|
            f.radio_button(:role_id, role.id) + f.label(:role_id, role.name, value: role.id)
          end
        end
      end

      def collection_checkboxes
        form(User.new(role_ids: [1])) { |f| f.collection_checkboxes :role_ids, User::ROLES, :id, :name }
      end

      def collection_radio_buttons
        form(User.new(role_id: 3)) { |f| f.collection_radio_buttons :role_id, User::ROLES, :id, :name }
      end
    end
  end
end
