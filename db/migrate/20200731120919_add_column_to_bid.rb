class AddColumnToBid < ActiveRecord::Migration
  def change
    unless column_exists?(:bids, :buyer_id)
      add_column :bids, :buyer_id, :integer
    end
  end
end
