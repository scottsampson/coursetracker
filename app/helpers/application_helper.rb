module ApplicationHelper
  
  def current_tab?(controller_name)
    controller.controller_name == controller_name
  end
  
  def not_competent(course_string)
    course = Course.find_by_name(course_string)
    course.courses_users.really_low_scores.collect{|score| score.user.username}.join(', ') if course
  end
  
  def novice(course_string)
    course = Course.find_by_name(course_string)
    course.courses_users.low_scores.collect{|score| score.user.username}.join(', ') if course
  end
  
  def over_half(score,total)
    score = 0 if score.nil?
    score/total.to_f < 0.50
  end
  
  def get_user_courses(user_id, project_id)
    course_ids = Tech.where({:user_id => user_id, :project_id => project_id}).map(&:course_id).uniq.compact
    Course.find_all_by_id(course_ids).map(&:name).join(", ").to_s
  end
  
  def get_user_info(user_id)
    User.find_by_id(user_id).name
  end
  
  def get_experienced_users(course_id)
    collection = Hash.new {|hash, key| hash[key] = 0}
    Tech.where({:course_id => course_id}).where("user_id IS NOT NULL").group("user_id, project_id").each {|tech| collection[tech.user.name] += 1}
    collection
  end
end