class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.xml
  def welcome
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end
  
  def index
    @courses = Course.all
    @resource = Resource.new
    @levels = Level.all
    @current_level = -1;

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end
  
  def project_tech
    @project = Project.find_by_id(params[:project_id])
    params['question_ids'].each do |answer|
      puts answer.inspect
      values = {:question_id => answer[0],:answer => answer[1], :project_id => params['project_id']}
      Answer.create(values)
    end
    params['project']['course_ids'].each do |answer|
      puts answer.inspect
      values = {:course_id => answer,:user_id => @current_user.id, :project_id => @project.id}
      Tech.create(values)
    end
    redirect_to(answers_project_select_path, :notice => "Tech added to #{@project.name}")

  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
  
  def save_user
    puts 'params' + params.inspect
    #have to do this crap because active record doesn't work without an id field
    if params['course_id'].include?("'") || params['user_id'].include?("'") || params['know'].include?("'")
    else 
      ActiveRecord::Base.connection.execute "delete from courses_users where course_id = '#{params['course_id']}' and user_id = '#{params['user_id']}'"
      ActiveRecord::Base.connection.execute "insert into courses_users values ('','#{params['course_id']}','#{params['user_id']}','#{params['know']}',now(),now())"
    end
    render :nothing => true
  end
  
end
