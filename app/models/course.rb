class Course < ActiveRecord::Base
  belongs_to :target
  belongs_to :level
  has_many :courses_users
  has_many :users, :through => :courses_users
  has_many :prerequisites
  has_many :exercises, :through => :prerequisites
  scope :with_know_score, joins("left JOIN `courses_users` ON `courses_users`.`course_id` = `courses`.`id` INNER JOIN `levels` ON `levels`.`id` = `courses`.`level_id`").group("courses.id").select(["courses.*"," sum(courses_users.know) as know_score, levels.name as level_name"]).order('level_id, know_score')  

  # default_scope order('level_id, order_num')  
  
  #this is used in the reports
  attr_accessor :dont_know 
  
  def ==(another_course)
    self.id == another_course.id ? true : false
  end
  
  def <=>(another_course)
    self.name <=> another_course.name
  end
  
  def novice
    self.courses_users.low_scores.collect{|score| score.user.username}.join(', ')
  end
  
  def not_competent
    self.courses_users.really_low_scores.collect{|score| score.user.username}.join(', ')
  end
end
