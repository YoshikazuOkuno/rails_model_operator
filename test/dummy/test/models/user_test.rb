require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'operator is nil on create' do
    user = User.new(name: "test")
    user.operator = nil
    result = user.save

    assert_equal true, result
    assert_nil user.created_by
    assert_nil user.updated_by
    assert_nil user.deleted_by
  end

  test 'operator is not nil on create' do
    operator = User.create(name: "operator")
    user = User.new(name: "test")
    user.operator = operator
    user.save

    assert_equal operator.id, user.created_by
    assert_equal operator.id, user.updated_by
    assert_nil user.deleted_by
  end

  test 'operator is set expressly on create' do
    operator1 = User.create(name: "operator1")
    operator2 = User.create(name: "operator2")
    user = User.new(name: "test")
    user.operator = operator1
    user.created_by = operator2.id
    user.updated_by = operator2.id
    user.save

    assert_equal operator2.id, user.created_by
    assert_equal operator2.id, user.updated_by
    assert_nil user.deleted_by
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
    assert_nil user.deleted_by
  end

  test 'operator is nil on update' do
    operator = nil
    user = User.new(name: "test")
    user.operator = operator
    user.save
    user.name = "test:modify"
    user.save

    assert_nil user.created_by
    assert_nil user.updated_by
    assert_nil user.deleted_by
  end

  test 'operator is nil on soft delete' do
    operator = nil
    user = User.new(name: "test")
    user.operator = operator
    user.save
    user.deleted_at = Time.now
    user.save

    assert_not_nil user.deleted_at
    assert_nil user.deleted_by
  end

  test 'operator is set on soft delete' do
    operator = User.create(name: "operator")
    user = User.new(name: "test")
    user.operator = operator
    user.save
    user.deleted_at = Time.now
    user.save

    assert_not_nil user.deleted_at
    assert_equal operator.id, user.deleted_by

    user.deleted_at = nil
    user.save

    assert_nil user.deleted_at
    assert_nil user.deleted_by
  end
end
