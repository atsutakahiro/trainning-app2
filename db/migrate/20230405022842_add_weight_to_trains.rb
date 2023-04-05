class AddWeightToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :weight, :integer
    add_column :trains, :rep, :integer
  end
end
