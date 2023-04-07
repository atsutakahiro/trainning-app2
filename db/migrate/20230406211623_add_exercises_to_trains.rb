class AddExercisesToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :chest_exercises, :string
    add_column :trains, :shoulder_exercises, :string
    add_column :trains, :biceps_exercises, :string
    add_column :trains, :triceps_exercises, :string
    add_column :trains, :abdominal_exercises, :string
    add_column :trains, :back_exercises, :string
    add_column :trains, :reg_exercises, :string
  end
end
