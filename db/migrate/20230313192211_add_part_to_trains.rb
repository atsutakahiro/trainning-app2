class AddPartToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :part, :string
  end
end
