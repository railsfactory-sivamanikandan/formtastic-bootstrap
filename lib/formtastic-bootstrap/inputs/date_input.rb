module FormtasticBootstrap
  module Inputs
    class DateInput < Formtastic::Inputs::DateSelectInput
      include Base
      include Base::Stringish
      include Base::Timeish

      def to_html
        generic_input_wrapping do
          date_input_html
        end
      end

    end
  end
end