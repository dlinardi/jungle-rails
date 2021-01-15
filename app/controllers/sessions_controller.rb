class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def validate_email(email)
    email = email.strip
    email.downcase!
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
