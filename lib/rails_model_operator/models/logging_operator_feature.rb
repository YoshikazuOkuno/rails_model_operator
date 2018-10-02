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
        if new_record?
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
        set_deleted_operator_value!
      end

      private
      def operator_target_column?(column)
        has_attribute?(column) && !attribute_changed?(column)
      end

      def set_operator_value!(column)
        if operator_target_column?(column)
          write_attribute(column, operator_primary_key_value)
        end
      end

      def operator_primary_key_value
        operator.read_attribute(operator.class.primary_key) unless operator.nil?
      end

      def deleted_value?(column)
        # override here
        read_attribute(column).present?
      end

      def set_deleted_operator_value!
        deleted_flag = RailsModelOperator.deleted_flag_column
        deleted_by = RailsModelOperator.deleted_column
        if has_attribute?(deleted_flag) && attribute_changed?(deleted_flag) && operator_target_column?(deleted_by)
          value = deleted_value?(deleted_flag) ? operator_primary_key_value : nil
          write_attribute(deleted_by, value)
        end
      end
    end
  end
end

