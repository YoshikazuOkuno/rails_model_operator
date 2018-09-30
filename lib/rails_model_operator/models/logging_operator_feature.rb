module RailsModelOperator
  module LoggingOperatorFeature
    extend ActiveSupport::Concern

    included do |klass|
      before_save :logging_operator

      def operator
        Thread.current[RailsModelOperator.thread_name.to_sym]
      end

      def operator=(o)
        RailsModelOperator.operator = o
      end

      def logging_operator
        if self.new_record?
          set_operator_on_create
        else
          set_operator_on_update
        end
      end

      def set_operator_on_create
        if operator.present?
          set_operator_value!(RailsModelOperator.created_column)
          set_operator_value!(RailsModelOperator.updated_column)
        end
      end

      def set_operator_on_update
        if operator.present?
          set_operator_value!(RailsModelOperator.updated_column)
        end
      end

      private
      def set_operator_value!(column)
        if self.has_attribute?(column.to_sym) && !operator_column_changed?(column)
          self.send("#{column.to_s}=", primary_key_value)
        end
      end

      def operator_column_changed?(column)
	self.try("#{column.to_s}_changed?")
      end

      def primary_key_value
        operator.try(operator.class.primary_key.to_sym)
      end
    end
  end
end

