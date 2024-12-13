module FormtasticBootstrap
  module Helpers
    module FieldsetWrapper

      include Formtastic::Helpers::FieldsetWrapper

      protected

      def field_set_and_list_wrapping(*args, &block) #:nodoc:
        contents = args.last.is_a?(::Hash) ? '' : args.pop.flatten
        html_options = args.extract_options!

        if block_given?
          contents = if template.respond_to?(:is_haml?) && template.is_haml?
            template.capture_haml(&block)
          else
            template.capture(&block)
          end
        end

        # Ruby 1.9: String#to_s behavior changed, need to make an explicit join.
        contents = contents.join if contents.respond_to?(:join)

        legend = field_set_legend(html_options)
        fieldset = template.content_tag(:fieldset,
          legend.html_safe << contents.html_safe,
          html_options.except(:builder, :parent, :name)
        )

        fieldset
      end

      def field_set_legend(html_options)
        legend  = (html_options[:name] || '').to_s
        legend %= parent_child_index(html_options[:parent]) if html_options[:parent]
        legend  = template.content_tag(:legend, legend.html_safe) unless legend.blank?
        legend
      end

    end
  end
end
