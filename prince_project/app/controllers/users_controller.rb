class UsersController < ApplicationController
  layout "Landing"
  skip_before_filter :authorization, :authentication  
  
  def sign_up
    @user = User.new
  end
  
 
  def process_sign_up
    @user = User.new(params[:user])
    user = validate_password(@user)       
    if !user.errors.empty?
        render :action => :sign_up
      return
    end
    
    @user.password = params[:password]
    if @user.add_user!
      redirect_to :action => :complete_registration, :id => @user
    else
      render :action => :sign_up
    end
  end
  
  def complete_registration
    @user = User.find(params[:id])
  end
  
  def sign_in
    @user = User.new
  end
  
  def process_sign_in
      
    @user = User.try_to_logig(params[:username], params[:password])
    if @user
      flash[:notice] = "Logged in successful"
      save_session
      if current_admin
         redirect_to :controller => :products, :action =>  :admin_list
      elsif current_customer
         redirect_to :controller => :store
      end
    else
      @error_msg = "Username / password incorrect"
      render :action => :sign_in
    end
  end
  
  def sign_out
    remove_session
    flash[:notice] = "Sign out successful"
    redirect_to :action => :sign_in
  end
  
  def list
    render :layout => "application"
  end
  
  private 
  def validate_password(user)
    pswd = params[:password]
    cpswd = params[:confirm_password]
    errors = Array.new()
    if pswd.nil? || pswd.empty?
      user.errors[:base] << ("Password can't be blank")
    elsif cpswd.nil? || cpswd.empty?
       user.errors[:base] << ("Confirm Password can't be blank")
    elsif pswd != cpswd
       user.errors[:base] << ("Password mismatch")
    end 
    return user
  end
  

  
  def save_session
    session[:user_id] = @user.id
  end
  
  def remove_session
    session[:user_id] = nil
  end
end
