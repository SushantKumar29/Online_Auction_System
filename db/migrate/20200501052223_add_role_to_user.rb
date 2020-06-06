# frozen_string_literal: true

class AddRoleToUser < ActiveRecord::Migration
  def change
    unless column_exists?(:products, :role)
      add_column :users, :role, :integer
    end
  end
end
