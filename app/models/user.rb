class User < ActiveRecord::Base
  acts_as_voter
  has_many :courses_users
  has_many :techs
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
  
  def update_courses(course_ids)
    all_course_users = self.courses_users
    unknown_courses = all_course_users.where({:know => 0}).map(&:course_id)
    course_ids = course_ids.collect {|x| x.to_i}
    learned_courses = unknown_courses & course_ids
    learned_courses.each do |course_id|
      course = all_course_users.where({:course_id => course_id})
      course.first.update_attribute(:know,  1)
    end
  end
end
