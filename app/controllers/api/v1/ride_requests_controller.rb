class Api::V1::RideRequestsController < Api::ApplicationController

  def index
    ride_request = RideRequest.order(created_at: :desc)
    render(json: ride_request)
  end

  def create
    customer = Customer.find params[:customer_id]
    ride_request = RideRequest.new ride_request_params
    ride_request.user = user
    ride_request.customer = current_user

    if review.save
      render json: {id: review.id}
     else
       render(
         json: { errors: review.errors },
         status: 422 
       )
     end
  end

  def destroy
    @ride_request = RideRequest.find params[:id]
    @ride_request.destroy
    render(json: { status: 200 }, status: 200)
  end

  private
  def ride_request_params
    params.require(:ride_request).permit(:status, :ride_date, :ride_time)
  end
end
