class Workout < ApplicationRecord

  has_and_belongs_to_many :exercises
  belongs_to              :user

  validates :name, presence: true

  def add_exercises( exercise_ids )
    return unless exercise_ids.present?

    exercises = Exercise.where( id: exercise_ids )

    if exercises.present?
      self.exercises = exercises
    end
  end

  def response
    {
      workout: self,
      exercises: self.exercises
    }
  end

end
