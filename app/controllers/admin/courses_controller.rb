class Admin::CoursesController < Admin::ApplicationController
  # GET /courses
  # GET /courses.xml
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
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
    @targets = Target.find(:all)
    @levels = Level.find(:all)
    @level_count = Course.count(:conditions => "level_id = '#{@course.level_id}'") + 1
    @level_options = [['Choose One',0]]
    for i in 1..@level_count
      @level_options << [i,i]
    end
    puts "abc" + @level_options.inspect
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    @targets = Target.find(:all)
    @levels = Level.find(:all)
    @level_count = Course.count(:conditions => "level_id = '#{@course.level_id}'") + 1
    @level_options = [['Choose One',0]]
    for i in 1..@level_count
      @level_options << [i,i]
    end
  end
  
  # GET /courses/1/edit
  def level_count
    
    @level_count = Course.count(:conditions => "level_id = '#{params[:level_id]}'") + 1
    @level_options = [['Choose One',0]]
    for i in 1..@level_count
      @level_options << [i,i]
    end
    puts @level_options.inspect
    render :layout => false
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])
    ActiveRecord::Base.connection.execute "update courses set order_num = order_num + 1 where order_num >= '#{params[:course][:order_num]}' and level_id = '#{@course.level_id}'"
    respond_to do |format|
      if @course.save
        format.html { redirect_to([:admin,@course], :notice => 'Course was successfully created.') }
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
    if @course.level_id != params[:course][:level_id].to_i
      ActiveRecord::Base.connection.execute "update courses set order_num = order_num - 1 where order_num > '#{@course.order_num}' and level_id = '#{@course.level_id}'"
    end
    if @course.order_num < params[:course][:order_num].to_i
      ActiveRecord::Base.connection.execute "update courses set order_num = order_num - 1 where order_num > '#{@course.order_num}' and order_num <= '#{params[:course][:order_num]}' and level_id ='#{params[:course][:level_id]}'"
    elsif @course.order_num > params[:course][:order_num].to_i
      ActiveRecord::Base.connection.execute "update courses set order_num = order_num + 1 where order_num >= '#{params[:course][:order_num]}' and level_id ='#{params[:course][:level_id]}'"
    end

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to([:admin,@course], :notice => 'Course was successfully updated.') }
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
      format.html { redirect_to(admin_courses_url) }
      format.xml  { head :ok }
    end
  end
  
  def reorder
    levels = Level.all
    levels.each { |level|
      courses = Course.where({:level_id => level.id})
      courses.each_with_index { |course,index|
        puts "index " + index.to_s
        course.order_num = (index + 1)
        course.save!
      }
    }
    redirect_to(admin_courses_path, :notice => 'Order was successfully updated.')
  end
end
