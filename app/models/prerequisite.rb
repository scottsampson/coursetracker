class Prerequisite < ActiveRecord::Base
  belongs_to :course
  belongs_to :exercise
  
  def ==(another_prereq)
    self.course_id == another_prereq.course_id && self.exercise_id = another_prereq.exercise_id ? true : false
  end
end