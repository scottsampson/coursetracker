class Admin::ExercisesController < Admin::ApplicationController
  # GET /exercises
  # GET /exercises.xml
  def index
    @exercises = Exercise.all()
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exercises }
    end
  end

  # GET /exercises/1
  # GET /exercises/1.xml
  def show
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exercise }
    end
  end

  # GET /exercises/new
  # GET /exercises/new.xml
  def new
    @exercise = Exercise.new
    @order_count = Exercise.count() + 1
    @order_options = [['Choose One',0]]
    for i in 1..@order_count
      @order_options << [i,i]
    end
    @courses = Course.all
    @prereq_course_ids = []
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exercise }
    end
  end

  # GET /exercises/1/edit
  def edit
    @exercise = Exercise.find(params[:id])
    #RAILS_DEFAULT_LOGGER.debug c(@exercise.methods.sort.inspect)
    #RAILS_DEFAULT_LOGGER.debug c(@exercise.prerequisites.inspect)
    @order_count = Exercise.count()
    @order_options = [['Choose One',0]]
    for i in 1..@order_count
      @order_options << [i,i]
    end
    @prereq_course_ids = @exercise.prerequisites.collect{|pre| pre.course_id}
    @courses = Course.all
    #@exercise.prerequisites << @courses.collect{|course| p = Prerequisite.new({:course_id => course.id, :exercise_id => @exercise.id}); p unless prereqs.include?(p)}.compact!
    #RAILS_DEFAULT_LOGGER.debug "exercise" + @exercise.methods.sort.inspect
    #RAILS_DEFAULT_LOGGER.debug "prereqs" + @prequisites.inspect
  end

  # POST /exercises
  # POST /exercises.xml
  def create
    @exercise = Exercise.new(params[:exercise])
    ActiveRecord::Base.connection.execute "update exercises set order_num = order_num + 1 where order_num >= '#{params[:exercise][:order_num]}'"

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to([:admin,@exercise], :notice => 'Exercise was successfully created.') }
        format.xml  { render :xml => @exercise, :status => :created, :location => @exercise }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exercise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exercises/1
  # PUT /exercises/1.xml
  def update
    puts params[:exercise]["courses"].inspect
    new_prerequisites = params[:exercise]["prerequisites_attributes"].collect{|ind,course| Prerequisite.new({:course_id => course["course_id"].to_i, :exercise_id => params[:id]})  unless course["course_id"] == ""}.compact!
    params[:exercise]["prerequisites_attributes"] = []
    @exercise = Exercise.find(params[:id])
    if @exercise.order_num < params[:exercise][:order_num].to_i
      ActiveRecord::Base.connection.execute "update exercises set order_num = order_num - 1 where order_num > '#{@exercise.order_num}' and order_num <= '#{params[:exercise][:order_num]}'"
    elsif @exercise.order_num > params[:exercise][:order_num].to_i
      ActiveRecord::Base.connection.execute "update exercises set order_num = order_num + 1 where order_num >= '#{params[:exercise][:order_num]}'"
    end
    respond_to do |format|
      if @exercise.update_attributes(params[:exercise])
        #had to add the below query because I kept getting the following error
        #undefined method `in' for nil:NilClass
        ActiveRecord::Base.connection.execute "delete from prerequisites where exercise_id = '#{@exercise.id}'"
        @exercise.prerequisites = new_prerequisites
        format.html { redirect_to([:admin,@exercise], :notice => 'Exercise was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exercise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.xml
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy

    respond_to do |format|
      format.html { redirect_to(admin_exercises_url) }
      format.xml  { head :ok }
    end
  end
end
