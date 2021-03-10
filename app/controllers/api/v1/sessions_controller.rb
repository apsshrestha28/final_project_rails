class Api::V1::SessionsController < Api::ApplicationController
  def create
        @user = User.find_by(email: params[:email])
        if @user 
            if @user && @user.authenticate(params[:password])
              session[:user_id] = @user.id
              puts "print session id"
              puts session[:user_id]
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
                puts "print customer session id"
                puts session[:customer_id]
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
    if session[:user_id]
      session[:user_id] = nil
      render(
        json: { logged_out: true },
        status: 200
      )
    end
    if session[:customer_id]
      session[:customer_id] = nil
      render(
        json: { logged_out: true },
        status: 200
      )
    end
  end

  def get_current_user
    render json: current_user
  end

  def current_user
    puts "print session userid"
    puts session[:user_id]
    if session[:user_id].present?
      @current_user ||=User.find_by_id session[:user_id]
      puts @current_user

  elsif session[:customer_id].present?
      puts "customer id session"
      puts session[:customer_id]
      puts "print current user"
      puts @current_user
      @current_user ||=Customer.find_by_id session[:customer_id]
    end
  end
  helper_method :current_user
end