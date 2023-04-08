class AddRmToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :rm, :integer
  end
end
