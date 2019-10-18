class DocumentsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_student, :only => [:index, :new, :edit]

  def index
    @documents = (@student) ? @student.documents.paginate(:page => params[:page]) : Document.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(params[:document])

    @student = Student.find(params[:student_id])

    @document.attachable = @student

    if @document.save
      flash[:notice] = 'Document was successfully created.'
      redirect_to(@document)
    else
      render :action => "new"
    end
  end

  def update
    if @document.update_attributes(params[:document])
      flash[:notice] = 'Document was successfully updated.'
      redirect_to(@document)
    else
      render :action => "edit"
    end
  end

  def destroy
    @document.destroy
    redirect_to(documents_url(:student_id => @document.attachable.id))
  end

  private

    def set_student
      @student = params[:student_id].present? ? Student.find(params[:student_id]) : nil
    end
end
