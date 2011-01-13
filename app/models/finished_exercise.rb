class FinishedExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
end
