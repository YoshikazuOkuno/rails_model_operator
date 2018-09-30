require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'operator is nil on create' do
    user = User.new(name: "test")
    user.operator = nil
    result = user.save

    assert_equal true, result
    assert_nil user.created_by
    assert_nil user.updated_by
  end

  test 'operator is not nil on create' do
    operator = User.create(name: "operator")
    user = User.new(name: "test")
    user.operator = operator
    user.save

    assert_equal operator.id, user.created_by
    assert_equal operator.id, user.updated_by
  end

  test 'operator was set expressly on create' do
    operator1 = User.create(name: "operator1")
    operator2 = User.create(name: "operator2")
    user = User.new(name: "test")
    user.operator = operator1
    user.created_by = operator2.id
    user.updated_by = operator2.id
    user.save

    assert_equal operator2.id, user.created_by
    assert_equal operator2.id, user.updated_by
  end

  test 'operator is not nil on update' do
    operator1 = User.create(name: "operator1")
    operator2 = User.create(name: "operator2")
    user = User.new(name: "test")
    user.operator = operator1
    user.save
    user.operator = operator2
    user.name = "test:modify"
    user.save

    assert_equal operator1.id, user.created_by
    assert_equal operator2.id, user.updated_by
  end
end
