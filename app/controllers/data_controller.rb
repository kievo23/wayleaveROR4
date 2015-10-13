class DataController < ApplicationController
  #load_and_authorize_resource
  before_action :set_datum, only: [:show, :edit, :update, :destroy]
  skip_authorization_check
  # GET /data
  # GET /data.json
  def index
    if current_user
      if params[:search]
        @data = Datum.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @data = Datum.paginate(:page => params[:page], :per_page => 10)
      end
    else
      redirect_to log_in_path
    end
  end

  # GET /data/1
  # GET /data/1.json
  def show
  end

  def search
  end

  # GET /data/new
  def new
    if current_user
      @datum = Datum.new
      authorize! :create, @datum
    else
      redirect_to log_in_path
    end
  end

  # GET /data/1/edit
  def edit
  end

  # POST /data
  # POST /data.json
  def create
    #@datum = Datum.create(datum_params)
    @datum = Datum.new datum_params
    @datum.valid?

    #:permit_no, :route, :carriageway, :footpath, :verge, :amount_paid, :date_paid, :Remarks, :permit, :wayleave_file

    if params[:datum][:permit_no] == nil
      raise "Permit Number cannot be blank!" 
    end
    if params[:datum][:route] == nil
      raise "Route Number cannot be blank!" 
    end
    if params[:datum][:carriageway] == nil
      raise "Carriageway Number cannot be blank!" 
    end
    if params[:datum][:footpath] == nil
      raise "Footpath Number cannot be blank!" 
    end
    if params[:datum][:verge] == nil
      raise "Verge Number cannot be blank!" 
    end
    if params[:datum][:amount_paid] == nil
      raise "Amount Paid Number cannot be blank!" 
    end
    if params[:datum][:date_paid] == nil
      raise "Date Paid Number cannot be blank!" 
    end
    if params[:datum][:Remarks] == nil
      raise "Remarks Number cannot be blank!" 
    end

    if params[:datum][:permit] == nil
      raise "Permit file cannot be blank!" 
    end
    if params[:datum][:wayleave_file] == nil
      raise "wayleave file cannot be blank!" 
    end

    respond_to do |format|
      uploaded_iop = params[:datum][:permit]
      uploaded_iow = params[:datum][:wayleave_file]
      uploaded_ios = params[:datum][:invoice]

      @datum.permit  = uploaded_iop.original_filename
      @datum.wayleave_file = uploaded_iow.original_filename
      if not uploaded_ios.original_filename == nil
        @datum.invoice = uploaded_ios.original_filename
      end

      if @datum.save        
        File.open(Rails.root.join('public', 'uploads/permits', uploaded_iop.original_filename), 'wb') do |file|
          file.write(uploaded_iop.read)
        end        
        File.open(Rails.root.join('public', 'uploads/wayleaves', uploaded_iow.original_filename), 'wb') do |file|
          file.write(uploaded_iow.read)
        end

        File.open(Rails.root.join('public', 'uploads/invoice', uploaded_ios.original_filename), 'wb') do |file|
          file.write(uploaded_ios.read)
        end

        format.html { redirect_to @datum, notice: 'Datum was successfully created' }
        format.json { render :show, status: :created, location: @datum }
      else
        format.html { render :new }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
    authorize! :create, @datum
  end

  # PATCH/PUT /data/1
  # PATCH/PUT /data/1.json
  def update
    respond_to do |format|
      if @datum.update(datum_params)
        format.html { redirect_to @datum, notice: 'Datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @datum }
      else
        format.html { render :edit }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
    authorize! :update, @datum
  end

  # DELETE /data/1
  # DELETE /data/1.json
  def destroy
    @datum.destroy
    respond_to do |format|
      format.html { redirect_to data_url, notice: 'Datum was successfully destroyed.' }
      format.json { head :no_content }
    end
    authorize! :destroy, @datum
  end

  def download
    require 'open-uri' 
    pdf_filename = File.join(Rails.root, "public/uploads/permits/#{params[:permit]}")
    send_file(pdf_filename, :filename => params[:permit], :type => "application/pdf", :disposition => 'inline')
    #@datum.pdf_filename
  end

  def downloadsof
    require 'open-uri' 
    pdf_filename = File.join(Rails.root, "public/uploads/invoice/#{params[:invoice]}")
    send_file(pdf_filename, :filename => params[:invoice], :type => "application/pdf", :disposition => 'inline')
    #@datum.pdf_filename
  end

  def downloadwayleave
    require 'open-uri' 
    pdf_filename = File.join(Rails.root, "public/uploads/wayleaves/#{params[:wayleave_file]}")
    send_file(pdf_filename, :filename => params[:wayleave_file], :type => "application/pdf", :disposition => 'inline')
    #@datum.pdf_filename
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datum
      @datum = Datum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datum_params
      params.require(:datum).permit(:permit_no, :route, :carriageway, :footpath, :verge, :amount_paid, :date_paid,:Renewal_date, :Remarks,:invoice, :permit, :wayleave_file)
    end
end
