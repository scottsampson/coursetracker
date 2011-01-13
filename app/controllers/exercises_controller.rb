class ExercisesController < ApplicationController
  # GET /exercises
  # GET /exercises.xml
  def index
    @exercises = Exercise.all()
    @finished_exercises = FinishedExercise.select('exercise_id').where(:user_id => @current_user.id, :finished => 1).collect{|exercise| exercise.exercise_id }
    puts   @finished_exercises.inspect
    #@course_ids = @current_user.courses.collect{|course| course.id }
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exercise }
    end
  end

  # GET /exercises/1/edit
  def edit
    @exercise = Exercise.find(params[:id])
  end

  # POST /exercises
  # POST /exercises.xml
  def create
    @exercise = Exercise.new(params[:exercise])

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to(@exercise, :notice => 'Exercise was successfully created.') }
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
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      if @exercise.update_attributes(params[:exercise])
        format.html { redirect_to(@exercise, :notice => 'Exercise was successfully updated.') }
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
      format.html { redirect_to(exercises_url) }
      format.xml  { head :ok }
    end
  end
  
  def save_finished
    #have to do this crap because active record doesn't work without an id field
    if params['exercise_id'].include?("'") || params['user_id'].include?("'") || params['finished'].include?("'")
    else 
      ActiveRecord::Base.connection.execute "delete from finished_exercises where exercise_id = '#{params['exercise_id']}' and user_id = '#{params['user_id']}'"
      ActiveRecord::Base.connection.execute "insert into finished_exercises values ('','#{params['exercise_id']}','#{params['user_id']}','#{params['finished']}',now(),now())"
    end
    render :nothing => true
  end
end
