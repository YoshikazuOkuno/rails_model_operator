class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.bigint :created_by, index: true, null: true
      t.bigint :updated_by, index: true, null: true

      t.timestamps
      t.datetime :deleted_at, null: true
      t.bigint :deleted_by, index: true, null: true

    end
    add_foreign_key :users, :users, column: :created_by
    add_foreign_key :users, :users, column: :updated_by
    add_foreign_key :users, :users, column: :deleted_by
  end
end
