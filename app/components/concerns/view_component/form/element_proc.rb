# frozen_string_literal: true

module ViewComponent
  module Form
    module ElementProc
      attr_reader :element_proc

      def initialize(*args, **kwargs)
        super
        set_element_proc!
      end

      protected

      def set_element_proc!
        options_element_proc = options.delete(:element_proc)
        html_options_element_proc = html_options.delete(:element_proc)

        if options_element_proc && html_options_element_proc
          raise ArgumentError, "#{self.class.name} received :element_proc twice, expected only once"
        end

        @element_proc = options_element_proc || html_options_element_proc
      end
    end
  end
end
