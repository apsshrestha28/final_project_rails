class ApplicationController < ActionController::Base
 private
  def current_user
    puts "print session userid"
    puts session[:user_id] # not printed
    if session[:user_id].present?
      @current_user ||=User.find_by_id session[:user_id]

  elsif session[:customer_id].present?
      puts "customer id session"
      puts session[:customer_id]
      puts "print current user"
      @current_user ||=Customer.find_by_id session[:customer_id]
    end
  end
  helper_method :current_user
end
