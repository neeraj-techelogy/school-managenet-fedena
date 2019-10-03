class DocumentsController < ApplicationController
  before_filter :set_student, :only => [:index, :new, :edit]

  def index
    @documents = (@student) ? @student.documents : Document.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @document = Document.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(params[:document])

    @student = Student.find(params[:student_id])

    @document.attachable = @student

    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully created.'
        format.html { redirect_to(@document) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        flash[:notice] = 'Document was successfully updated.'
        format.html { redirect_to(@document) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(documents_url(:student_id => @document.attachable.id)) }
    end
  end

  private

    def set_student
      @student = params[:student_id].present? ? Student.find(params[:student_id]) : nil
    end
end
