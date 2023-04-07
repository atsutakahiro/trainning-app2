class AddExeToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :exercises, :string
  end
end
