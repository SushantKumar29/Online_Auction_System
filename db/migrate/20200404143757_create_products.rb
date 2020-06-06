# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration
  def change
    return if table_exists?(:products)

    create_table :products do |t|
      t.string :name
      t.float :price
      t.text :description

      t.timestamps null: false
    end
  end
end
