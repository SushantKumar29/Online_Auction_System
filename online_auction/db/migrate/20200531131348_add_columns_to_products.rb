# frozen_string_literal: true

class AddColumnsToProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:products, :minimum_bid)
      add_column :products, :minimum_bid, :decimal, precision: 15, scale: 2, null: false, default: 0.0
    end
    unless column_exists?(:products, :current_bid)
      add_column :products, :current_bid, :decimal, precision: 15, scale: 2, null: false, default: 0.0
    end
  end
end
