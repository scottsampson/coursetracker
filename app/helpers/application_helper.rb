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
    score/total.to_f > 0.50
  end
end
