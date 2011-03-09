class AnswersController < ApplicationController
  before_filter :except => [:project_select,:answer_questions,:save_answers] do |c| 
    c.show_navigation(true) 
  end
  before_filter :only => [:project_select,:answer_questions,:save_answers] do |c| 
    c.show_navigation(false)
  end
  
  def project_select
    @projects = Project.all
    @answer = Answer.new
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  
  def answer_questions
    @questions = Question.joins(" left join answers on answers.question_id = questions.id and answers.project_id = '#{params['answer']['project_id']}' and answers.user_id = '#{@current_user.id}'").select("questions.*,answers.answer ").all
    @answer = Answer.new
    @courses_checked = Course.joins(" join teches on teches.course_id = courses.id").where("teches.user_id = '?' and teches.project_id = ?",@current_user.id,params['answer']['project_id'])
    @project = Project.find_by_id(params['answer']['project_id']);
    @courses = Course.all
    pu = ProjectsUsers.find_by_user_id_and_project_id(@current_user.id,params['answer']['project_id'])
    @already_answered = pu.nil? ? false : pu.submitted
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def save_answers
    puts 'got inside save answers'
    puts params.inspect
    puts 'current_user - ' + @current_user.inspect
    params['question_ids'].each do |answer|
      puts answer.inspect
      values = {:question_id => answer[0],:answer => answer[1], :project_id => params['project_id'], :user_id => @current_user.id}
      Answer.new(values).save
    end
    submitted = params['commit'] == "Submit" ? true : false;
    
    ProjectsUsers.new({:user_id => @current_user.id,:project_id => params['project_id'],:submitted => submitted}).save_or_create
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /answers
  # GET /answers.xml
  def index
    @questions = Question.all
    @projects = Project.all
    if !params['answer'].nil?
      @answers = Answer.select("questions.question, answers.*").joins("join questions on questions.id = answers.question_id").where(:project_id => params['answer']['project_id']).order("answers.question_id")
    end
    @answer = Answer.new()

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@answer, :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
end
