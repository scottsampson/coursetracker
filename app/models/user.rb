class User < ActiveRecord::Base
  acts_as_voter
  has_many :courses_users
  has_many :courses, :through => :courses_users
  has_many :finished_exercises
  has_many :exercises, :through => :finished_exercises
  
  def known_courses
    self.courses.collect{|course| course if course.courses_users.first.know == true }.compact
  end
  
  def known_beginner
    self.courses.collect{|course| course if course.courses_users.first.know == true && course.level_id == 1 }.compact
  end
  
  def known_intermediate
    self.courses.collect{|course| course if course.courses_users.first.know == true && course.level_id == 2 }.compact
  end
  
  def known_expert
    self.courses.collect{|course| course if course.courses_users.first.know == true && course.level_id == 3 }.compact
  end
  
  def name
    full_name ? full_name : username
  end
end
