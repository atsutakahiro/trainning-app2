class AddNameToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :name, :string
  end
end
