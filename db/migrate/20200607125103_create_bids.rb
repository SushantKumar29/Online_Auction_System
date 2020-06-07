# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration
  def change
    return if table_exists?(:bids)

    create_table :bids do |t|
      t.string :buyer_name
      t.decimal :current_bid, precision: 15, scale: 2
      t.decimal :sold_price, precision: 15, scale: 2
      t.string :status

      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
