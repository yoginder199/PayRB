class SessionsController < ApplicationController
def create
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id

    if user.role == "admin"
      redirect_to users_path, notice: "Welcome, Admin!"
    else
      redirect_to profile_path, notice: "Logged in successfully."
    end
  else
    flash.now[:alert] = "Invalid email or password"
    render :new
  end
end

def destroy
  session[:user_id] = nil
  redirect_to login_path, notice: "Logged out successfully."
end

end
