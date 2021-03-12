class Api::V1::SessionsController < Api::ApplicationController
  def create
        @user = User.find_by(email: params[:email])
        if @user 
            if @user && @user.authenticate(params[:password])
              session[:user_id] = @user.id
              render json: { id: @user.id }
            else
              render(
                json: { status: 404 },
                status: 404
              )
            end

        elsif @customer = Customer.find_by(email: params[:email])
          if @customer
              if @customer && @customer.authenticate(params[:password])
                session[:customer_id] = @customer.id
                render json: { id: @customer.id }
              else
                render(
                  json: { status: 404 },
                  status: 404
                )
              end
          end
        else  
          render(
            json: { status: 404 },
            status: 404
          )
        end
  end

  def destroy
    current_user.invalidate_all_sessions!
    super
  end

  def get_current_user
    render json: current_user
  end

end