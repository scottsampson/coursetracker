class Admin::QuestionsController < Admin::ApplicationController
  # GET /admin/questions
  # GET /admin/questions.xml
  def index
    @questions = Admin::Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_questions }
    end
  end

  # GET /admin/questions/1
  # GET /admin/questions/1.xml
  def show
    @question = Admin::Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_question }
    end
  end

  # GET /admin/questions/new
  # GET /admin/questions/new.xml
  def new
    @question = Admin::Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_question }
    end
  end

  # GET /admin/questions/1/edit
  def edit
    @question = Admin::Question.find(params[:id])
  end

  # POST /admin/questions
  # POST /admin/questions.xml
  def create
    @question = Admin::Question.new(params[:question])

    respond_to do |format|
      if @question.save
        
        format.html { redirect_to([:admin,@question], :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/questions/1
  # PUT /admin/questions/1.xml
  def update
    @question = Admin::Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to([:admin, @question], :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.xml
  def destroy
    @question = Admin::Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(admin_questions_url) }
      format.xml  { head :ok }
    end
  end
end
