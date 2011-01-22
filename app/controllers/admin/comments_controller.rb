class Admin::CommentsController < ApplicationController
  respond_to :html
  # GET /admin_comments
  def index
    @admin_comments = Admin::Comment.all
  end

  # GET /admin_comments/1
  def show
    @comment = Admin::Comment.find(params[:id])
  end

  # GET /admin_comments/new
  def new
    @comment = Admin::Comment.new
  end

  # GET /admin_comments/1/edit
  def edit
    @comment = Admin::Comment.find(params[:id])
  end

  # POST /admin_comments
  def create
    @comment = Admin::Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = 'Admin::Comment was successfully created.'
      redirect_to(@comment)
    else
      render :action => "new"
    end
  end

  # PUT /admin_comments/1
  # PUT /admin_comments/1.xml
  def update
    @comment = Admin::Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Admin::Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_comments/1
  # DELETE /admin_comments/1.xml
  def destroy
    @comment = Admin::Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_comments_url) }
      format.xml  { head :ok }
    end
  end
end
