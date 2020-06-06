# frozen_string_literal: true

class AddUserIdToProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:products, :user_id)
      add_column :products, :user_id, :integer
    end
  end
end
