class CreateRepeats < ActiveRecord::Migration[5.1]
  def change
    create_table :repeats do |t|
      t.integer :sets
      t.text :remark
      t.references :train, foreign_key: true

      t.timestamps
    end
  end
end
