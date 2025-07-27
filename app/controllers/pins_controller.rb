class PinsController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    if current_user.update(pin: params[:pin])
      redirect_to new_transfer_path, notice: "PIN created successfully."
    else
      flash.now[:alert] = "Failed to set PIN."
      render :new
    end
  end
end
