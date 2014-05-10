class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery
  before_filter :authentication, :authorization
  
  def authentication
     if !current_user
       flash[:error] = "Not authorized to access this page"
       redirect_to :controller => :users, :action => :sign_in and return
     end
     
     if current_customer && (!customer_controllers.include?controller_name) 
       flash[:error] = "Not authorized to access this page"
        redirect_to :controller => :store and return
     end
   
     if current_admin && (!admin_controllers.include?controller_name)
       flash[:error] = "Not authorized to access this page"
       redirect_to :controller => :products
     end
  end
  
  def admin_controllers
    ["categories","products", "users"]
  end
  
  def customer_controllers
    ["store","users","orders"]
  end
  
  def authorization
  end
  
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  
  def current_admin
    if current_user
      current_user.roles.include? Role.admin
    end
  end
  
  def current_customer
    if current_user
      current_user.roles.include? Role.customer
    end
  end
end
