# frozen_string_literal: true

class AddColumnsToProducts < ActiveRecord::Migration
  def change
    unless column_exists?(:products, :last_bidding_date)
      add_column :products, :last_bidding_date, :datetime
    end
  end
end
