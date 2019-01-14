class CreateExercisesWorkouts < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises_workouts do |t|
      t.references :exercise, foreign_key: true
      t.references :workout, foreign_key: true
    end
  end
end
