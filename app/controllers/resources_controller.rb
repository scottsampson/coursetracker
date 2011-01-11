class ResourcesController < ApplicationController
  # GET /admin/resources
  # GET /admin/resources.xml
  def index
    @resources = Resource.find_all_by_course_id(params[:course_id])
    
    @resources = [] unless !@resources.nil?
    @course = Course.find_by_id(params[:course_id])
    puts @resources.inspect
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /admin/resources/1
  # GET /admin/resources/1.xml
  def show
    @admin_resource = Resource.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_resource }
    end
  end

  # GET /admin/resources/new
  # GET /admin/resources/new.xml
  def new
    @admin_resource = Resource.new
    @admin_resource.course_id = params[:course_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_resource }
    end
  end

  # GET /admin/resources/1/edit
  def edit
    @admin_resource = Resource.find(params[:id])
  end

  # POST /admin/resources
  # POST /admin/resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        format.html { redirect_to([:admin,@resource], :notice => 'Resource was successfully created.') }
        format.xml  { render :xml => [:admin,@resource], :status => :created, :location => @admin_resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/resources/1
  # PUT /admin/resources/1.xml
  def update
    @admin_resource = Resource.find(params[:id])

    respond_to do |format|
      if @admin_resource.update_attributes(params[:resource])
        format.html { redirect_to([:admin,@admin_resource], :notice => 'Resource was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/resources/1
  # DELETE /admin/resources/1.xml
  def destroy
    puts "got here"
    @admin_resource = Resource.find(params[:id])
    @admin_resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end
end
