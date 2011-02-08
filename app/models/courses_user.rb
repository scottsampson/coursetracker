class CoursesUser < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  scope :low_scores, lambda { { :conditions => ["know = ?", 1] } }
  scope :really_low_scores, lambda { { :conditions => ["know = ?", 0] } }
  
end
