class Admin::ReportsController < Admin::ApplicationController
  def index
    num_users = User.count()
    #once again....not sure how to do the following in active record
    #select *,(7 - (select count(*) from courses_users where know = '1' and courses_users.course_id = courses.id)) dont_know from courses order by dont_know desc    
    # sub1 = "(#{num_users} - (select count(*) from courses_users where courses_users.know = '1' and courses_users.course_id = courses.id)) dont_know"
    #     sub2 = "(select name from levels where levels.id = courses.level_id) level_name"
    #     @courses = ActiveRecord::Base.connection.execute "select name,#{sub1},#{sub2} from courses order by level_id, dont_know DESC"
    
    #this is what i changed
    # sub1 = "(select sum(courses_users.know) from courses_users where courses_users.course_id = courses.id) know_score"
    # sub2 = "(select levels.name from levels where levels.id = courses.level_id) level_name"
    # @courses = ActiveRecord::Base.connection.execute "select name,#{sub1},#{sub2} from courses order by level_id, know_score"
    # @total_score = User.count() * 2;
    #this is what i changed
    
    @courses = Course.with_know_score('know_score')
    @courses = Course.with_know_score(params[:sort_order]) unless params[:sort_order].nil?
    @turn_red = params[:sort_order] == "order_num" ? true : false
    
    @total_score = User.count * 2
    
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
  
  def courses
    #courses without prerequisites
    @courses = Course.where("id not in (select course_id from prerequisites)") 
  end
  
  # User profile to display a knowledge report in full detail.
  def profile
    @user = User.where("username = ?", params[:username]).first
    @courses = @user.courses_users.order('updated_at desc')
    
  end
  
end