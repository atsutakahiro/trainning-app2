class CreateTrains < ActiveRecord::Migration[5.1]
  def change
    create_table :trains do |t|
      t.string :exercise
      t.string :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
