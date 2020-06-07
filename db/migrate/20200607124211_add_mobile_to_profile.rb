# frozen_string_literal: true

class AddMobileToProfile < ActiveRecord::Migration
  def change
    unless column_exists?(:profiles, :mobile)
      add_column :profiles, :mobile, :string
    end
  end
end
