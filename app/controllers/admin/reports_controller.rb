class Admin::ReportsController < Admin::ApplicationController
  def index
    num_users = User.count()
    #once again....not sure how to do the following in active record
    #select *,(7 - (select count(*) from courses_users where know = '1' and courses_users.course_id = courses.id)) dont_know from courses order by dont_know desc    
    sub1 = "(#{num_users} - (select count(*) from courses_users where courses_users.know = '1' and courses_users.course_id = courses.id)) dont_know"
    sub2 = "(select name from levels where levels.id = courses.level_id) level_name"
    @courses = ActiveRecord::Base.connection.execute "select name,#{sub1},#{sub2} from courses order by level_id, dont_know DESC"
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def users
    @users = User.all()
    @total_beginner = Course.count(:conditions => "level_id = 1")
    @total_intermediate = Course.count(:conditions => "level_id = 2")
    @total_expert = Course.count(:conditions => "level_id = 3")
    @total_exercises = Exercise.count()
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end