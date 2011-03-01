class Admin::AnswersController < Admin::ApplicationController
  
  # GET /admin/answers
  # GET /admin/answers.xml
  # def index
  #   @answers = Answer.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @answers }
  #   end
  # end
  # 
  def index
    @questions = Question.all
    @projects = Project.all
    if !params['answer'].nil?
      @answers = Answer.select("questions.question, answers.*").joins("join questions on questions.id = answers.question_id").where(:project_id => params['answer']['project_id']).order("answers.question_id")
    end
    @answer = Answer.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /admin/answers/1
  # GET /admin/answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /admin/answers/new
  # GET /admin/answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /admin/answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /admin/answers
  # POST /admin/answers.xml
  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to([:admin, @answer], :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/answers/1
  # PUT /admin/answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to([:admin, @answer], :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/answers/1
  # DELETE /admin/answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(admin_answers_url) }
      format.xml  { head :ok }
    end
  end
end
