# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration
  def change
    return if table_exists?(:profiles)

    create_table :profiles do |t|
      t.string :name
      t.string :location
      t.string :country
      t.text :bio
      t.references :user, index: true, foreign_key: true
    end
  end
end
