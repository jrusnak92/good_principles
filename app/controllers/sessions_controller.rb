class SessionsController < ApplicationController

  def new
  
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    sign_out
    redirect_to root_path, :notice => "Signed out!"
  end
  
  def destroyFromOmniauth
    session[:user_id] = nil
  	redirect_to root_path, :notice => "Signed out!"
  end

  def createFromOmniauth
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

end