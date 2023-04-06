class AddSetNumberToRepeats < ActiveRecord::Migration[5.1]
  def change
    add_column :repeats, :set_number, :integer
  end
end
