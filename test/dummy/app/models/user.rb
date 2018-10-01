class User < ApplicationRecord
  include RailsModelOperator::LoggingOperatorFeature
  belongs_to :created, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updated, class_name: "User", foreign_key: "updated_by", optional: true
  belongs_to :deleted, class_name: "User", foreign_key: "deleted_by", optional: true
end
