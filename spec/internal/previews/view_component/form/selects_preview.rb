# frozen_string_literal: true

module ViewComponent
  module Form
    # @label Selects
    class SelectsPreview < ApplicationPreview
      def select
        form(User.new(role_id: 2)) { |f| f.select :role_id, [["Admin", 1], ["Editor", 2], ["Viewer", 3]] }
      end

      def select_with_blank
        form { |f| f.select :role_id, [["Admin", 1], ["Editor", 2], ["Viewer", 3]], include_blank: "Pick a role" }
      end

      def collection_select
        form(User.new(role_id: 2)) { |f| f.collection_select :role_id, User::ROLES, :id, :name }
      end

      def grouped_collection_select
        form(User.new(role_id: 3)) { |f| f.grouped_collection_select :role_id, User::TEAMS, :roles, :name, :id, :name }
      end

      def time_zone_select
        form(User.new(time_zone: "Paris")) { |f| f.time_zone_select :time_zone }
      end

      # With the [country_select](https://github.com/countries/country_select) gem
      def country_select
        form(User.new(country: "FR")) { |f| f.country_select :country, priority_countries: %w[FR DE] }
      end

      def weekday_select
        form(User.new(day_off: "Friday")) { |f| f.weekday_select :day_off }
      end
    end
  end
end
