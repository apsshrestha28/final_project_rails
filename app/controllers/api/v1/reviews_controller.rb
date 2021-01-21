class Api::V1::ReviewsController < Api::ApplicationController
  
  def create
    user= User.find params[:user_id]
    review = Review.new params.require(:review).permit(:description)
    review.user = user
    review.customer = current_user
    
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
    @review = Review.find params[:id]
    @review.destroy
    render(json: { status: 200 }, status: 200)
  end
end
