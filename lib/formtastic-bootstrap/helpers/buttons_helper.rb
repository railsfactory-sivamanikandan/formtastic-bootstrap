module FormtasticBootstrap
  module Helpers
    module ButtonsHelper

      include Formtastic::Helpers::ButtonsHelper

      def buttons(*args, &block)
        ::ActiveSupport::Deprecation.warn("f.buttons is deprecated in favour of f.actions and will be removed from Formtastic after 2.1. Please see ActionsHelper and InputAction or ButtonAction for more information")

        html_options = args.extract_options!
        html_options[:class] ||= "form-actions"

        if html_options.has_key?(:name)
          ActiveSupport::Deprecation.warn('The :name option is not supported')
        end

        if block_given?
          template.content_tag(:div, html_options) do
            yield
          end
        else
          args = [:commit] if args.empty?
          contents = args.map { |button_name| send(:"#{button_name}_button") }
          template.content_tag(:div, html_options.except(:builder, :parent, :name)) do
            contents.join.html_safe
          end
        end

      end

      def commit_button(*args)
        ::ActiveSupport::Deprecation.warn("f.commit_button is deprecated in favour of f.action(:submit) and will be removed from Formtastic after 2.1. Please see ActionsHelper and InputAction or ButtonAction for more information")

        options = args.extract_options!
        text = options.delete(:label) || args.shift

        text = (localized_string(commit_button_i18n_key, text, :action, :model => commit_button_object_name) ||
                Formtastic::I18n.t(commit_button_i18n_key, :model => commit_button_object_name)) unless text.is_a?(::String)

        button_html = options.delete(:button_html) || {}
        button_html[:id] ||= "#{@object_name}_submit"
        button_html.merge!(:class => [button_html[:class], "btn commit", commit_button_i18n_key].compact.join(' '))

        # TODO We don't have a wrapper. Add deprecation message.
        # wrapper_html = options.delete(:wrapper_html) || {}
        # wrapper_html[:class] = (commit_button_wrapper_html_class << wrapper_html[:class]).flatten.compact.join(' ')

        accesskey = (options.delete(:accesskey) || default_commit_button_accesskey) unless button_html.has_key?(:accesskey)
        button_html = button_html.merge(:accesskey => accesskey) if accesskey

        submit(text, button_html).html_safe
      end

    end
  end
end
