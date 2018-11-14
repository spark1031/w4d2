class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    render :new
  end
  
  def create
    request = CatRentalRequest.new(request_params)
    if request.save
      redirect_to cat_url(request.cat_id)
    else
      redirect_to new_cat_rental_request_url
    end
  end
  
  private
  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
  end
end