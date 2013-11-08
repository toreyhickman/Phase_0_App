class Exercise < ActiveRecord::Base

  has_many :attempts, class_name: "ExerciseAttempt"
  has_many :attempters, through: :attempts, source: :user
end
