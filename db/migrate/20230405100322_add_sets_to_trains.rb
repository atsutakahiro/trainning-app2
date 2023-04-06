class AddSetsToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :sets, :integer
  end
end
