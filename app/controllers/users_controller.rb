class UsersController < ApplicationController
  load_and_authorize_resource
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    authorize! :create, @user
  	if @user.save
  		redirect_to :controller => "data" , :action => "index", :notice => "Signed up!"
  	else
  		render "new"
  	end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end 
end
