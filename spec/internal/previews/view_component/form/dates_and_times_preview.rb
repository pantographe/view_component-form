# frozen_string_literal: true

module ViewComponent
  module Form
    # @label Dates and times
    class DatesAndTimesPreview < ApplicationPreview
      def date_field
        form(User.new(birthday: Date.new(1990, 4, 12))) { |f| f.date_field :birthday }
      end

      def datetime_local_field
        form(User.new(last_seen_at: Time.utc(2026, 1, 15, 9, 30))) { |f| f.datetime_local_field :last_seen_at }
      end

      def month_field
        form(User.new(birthday: Date.new(1990, 4, 12))) { |f| f.month_field :birthday }
      end

      def week_field
        form(User.new(birthday: Date.new(1990, 4, 12))) { |f| f.week_field :birthday }
      end

      def time_field
        form(User.new(wakes_up_at: Time.utc(2000, 1, 1, 7, 15))) { |f| f.time_field :wakes_up_at }
      end

      def date_select
        form(User.new(birthday: Date.new(1990, 4, 12))) { |f| f.date_select :birthday, start_year: 1950 }
      end

      def datetime_select
        form(User.new(last_seen_at: Time.utc(2026, 1, 15, 9, 30))) { |f| f.datetime_select :last_seen_at }
      end

      def time_select
        form(User.new(wakes_up_at: Time.utc(2000, 1, 1, 7, 15))) { |f| f.time_select :wakes_up_at }
      end
    end
  end
end
