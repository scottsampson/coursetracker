class Course < ActiveRecord::Base
  belongs_to :target
  belongs_to :level
  has_many :courses_users
  has_many :users, :through => :courses_users
  has_many :prerequisites
  has_many :exercises, :through => :prerequisites
  default_scope order('level_id, order_num')  
  
  #this is used in the reports
  attr_accessor :dont_know 
  
  def ==(another_course)
    self.id == another_course.id ? true : false
  end
  
  def <=>(another_course)
    self.name <=> another_course.name
  end
end
