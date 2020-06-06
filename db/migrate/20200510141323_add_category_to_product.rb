# frozen_string_literal: true

class AddCategoryToProduct < ActiveRecord::Migration
  def change
    unless column_exists?(:products, :category)
      add_reference :products, :category, index: true, foreign_key: true
    end
  end
end
