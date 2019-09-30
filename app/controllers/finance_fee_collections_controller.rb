class FinanceFeeCollectionsController < ApplicationController
  def index
    @finance_fee_collections = FinanceFeeCollection.hostel_fee_collections
  end

  def new
    if params[:student_id].present?
      @student = Student.find(params[:student_id])
      fee_category = @student.batch.find_or_create_hostel_fees_category
    end
    @finance_fee_collection = FinanceFeeCollection.new
  end

  def create
    if params[:finance_fee_collection][:batch_id].present?
      batch = Batch.find(params[:finance_fee_collection][:batch_id])
      students = batch.students
    else
      @student = Student.find(params[:student_id])
      batch = @student.batch
      students = [@student]
    end

    @finance_fee_collection = FinanceFeeCollection.new(params[:finance_fee_collection])
    @finance_fee_collection.fee_category = batch.find_or_create_hostel_fees_category

    respond_to do |format|
      if @finance_fee_collection.save
        # create FinanceFee for each student
        students.each do |student|
          if student.rooms.any?
            fee_particular = FeeCollectionParticular.create(
              :name => "Hostel room rent",
              :amount => student.rooms.first.rent_in_bucks,
              :finance_fee_collection_id => @finance_fee_collection.id,
              :admission_no => student.admission_no,
              :student_id => student.id
            )

            fee = FinanceFee.create(:fee_collection_id => @finance_fee_collection.id, :student_id => student.id)
          end
        end

        flash[:notice] = 'Fee collection was successfully created.'
        format.html { redirect_to(@finance_fee_collection) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def show
    @finance_fee_collection = FinanceFeeCollection.find(params[:id])
  end

  def edit
    @finance_fee_collection = FinanceFeeCollection.find(params[:id])
  end

  def update
    @finance_fee_collection = FinanceFeeCollection.find(params[:id])

    respond_to do |format|
      if @finance_fee_collection.update_attributes(params[:finance_fee_collection])
        flash[:notice] = 'Fee collection was successfully updated.'
        format.html { redirect_to(@finance_fee_collection) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @finance_fee_collection = FinanceFeeCollection.find(params[:id])
    @finance_fee_collection.destroy
    redirect_to finance_fee_collections_path
  end
end
