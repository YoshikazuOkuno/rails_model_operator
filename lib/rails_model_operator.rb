require "rails_model_operator/railtie"
require 'rails_model_operator/models'

module RailsModelOperator
  class << self
    def config
      @config ||= {
        thread_name: "operator",
        created_column: "created_by",
        updated_column: "updated_by",
        deleted_column: "deleted_by",
        deleted_flag_column: "deleted_at"
      }
    end

    def thread_name
      config[:thread_name]
    end

    def created_column
      config[:created_column]
    end

    def updated_column
      config[:updated_column]
    end

    def deleted_column
      config[:deleted_column]
    end

    def deleted_flag_column
      config[:deleted_flag_column]
    end

    def operator=(o)
      Thread.current[thread_name.to_sym] = o
    end
  end
end
