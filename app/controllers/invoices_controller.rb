class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  def new
    if params[:student_id].present?
      @student = Student.find(params[:student_id])
      @invoices = @student.invoices if @student
    end
    @invoice = Invoice.new
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.status = 'pending'

    # temporary values to pass validation
    @invoice.amount = Room.first.rent
    @invoice.payable = Room.first
    if params[:student_id].present?
      @invoice.payer = Student.find(params[:student_id])
    else
      @invoice.payer = Student.first
      @batch = Batch.find(params[:batch])
    end


    respond_to do |format|
      if @invoice.valid?
        students = []
        if @batch
          students = @batch.students
        else
           students << @invoice.payer
        end

        invoices_created = 0

        students.each do |student|
          invoice_copy = @invoice
          invoice_copy.payer = student
          if student.rooms.any?
            room = student.rooms.first
            invoice_copy.payable = room
            invoice_copy.amount = room.rent
            if invoice_copy.save
              invoices_created += 1
            end
          end
        end

        if @batch && !@batch.students.any?
          flash[:notice] = "No students in this batch"
          format.html { render :action => "new" }
        else
          flash[:notice] = "#{invoices_created} invoices created"
          format.html { redirect_to(invoices_path) }
        end
      else
        format.html { render :action => "new" }
      end
    end

  end

  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        flash[:notice] = 'Invoice was successfully updated.'
        format.html { redirect_to(@invoice) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to(invoices_url) }
      format.xml  { head :ok }
    end
  end

end
