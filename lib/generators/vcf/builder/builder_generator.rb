# frozen_string_literal: true

require "rails/generators"

module Vcf
  module Generators
    class BuilderGenerator < Rails::Generators::NamedBase
      source_root File.join(File.dirname(__FILE__), "templates")

      class_option :namespace, default: "Form"
      class_option :path,      default: "lib"

      def create_builder_from_template
        template "builder.rb.erb", destination
      end

      protected

      def class_name
        name.camelize
      end

      def components_namespace
        options[:namespace].camelize
      end

      def destination
        "#{options[:path]}/#{name.underscore}.rb"
      end
    end
  end
end
