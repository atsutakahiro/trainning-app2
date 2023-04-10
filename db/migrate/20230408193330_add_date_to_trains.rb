class AddDateToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :date, :date
  end
end
