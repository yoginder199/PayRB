class PinsController < ApplicationController
  before_action :require_login

 def new
    redirect_to new_transfer_path, notice: "PIN already set." if current_user.pin.present?
 end


  def create
    if params[:pin].blank?
      flash[:alert] = "PIN can't be blank"
      return render :new
    end

    current_user.update(pin: params[:pin])
    flash[:notice] = "PIN set successfully."
    redirect_to new_transfer_path
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in first."
    end
  end
end
