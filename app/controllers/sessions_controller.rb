class SessionsController < ApplicationController
  skip_authorization_check
  def new
  end

  def create
  	user = User.authenticate(params[:email],params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to :controller =>'data', :notice => "Logged in!"
  	else
  		#flash.now.alert = "Invalid email or password"
      flash[:alert] = {:class => 'alert alert-danger', :body => 'Invalid email or password'}
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to :controller => "data", :notice => "Logged out"
  end
end
