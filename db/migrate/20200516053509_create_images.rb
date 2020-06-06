# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration
  def change
    return if table_exists?(:images)

    create_table :images do |t|
      t.string :name
      t.integer :avatar_id
      t.string :avatar_type

      t.timestamps null: false
    end
  end
end
