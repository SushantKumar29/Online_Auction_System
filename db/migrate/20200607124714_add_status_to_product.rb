# frozen_string_literal: true

class AddStatusToProduct < ActiveRecord::Migration
  def change
    unless column_exists?(:products, :status)
      add_column :products, :status, :string
    end
  end
end
