class AddSetNumToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :set_num, :integer
  end
end
