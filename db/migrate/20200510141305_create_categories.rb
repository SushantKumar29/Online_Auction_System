# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration
  def change
    return if table_exists?(:categories)

    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
