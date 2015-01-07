class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all

    render :index
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :show
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      flash[:notice] = "Your request has been received"
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_rental_request_url(@request)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_rental_request_url(@request)
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @cat_rental_request = CatRentalRequest.update(params[:id], cat_rental_request_params)

    if @cat_rental_request.save
      flash[:notice] = "Your request was successfully edited"
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash[:errors] = @cat_rental_request.errors.full_messages
      render :edit
    end
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
