class TransfersController < ApplicationController
before_action :require_login
  before_action :check_pin_set, only: [ :new, :create ]

  def new
    # Display the transfer form
  end

  def create
    amount = params[:amount].to_f

    if amount <= 0
      return redirect_to new_transfer_path, alert: "Invalid amount"
    end

    # You can expand this logic to save a transfer record
    flash[:notice] = "Amount ₹#{amount} transferred successfully!"
    redirect_to root_path
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in first."
    end
  end

  def check_pin_set
    unless current_user.pin.present?
      redirect_to new_pin_user_path(current_user), alert: "You must set a PIN before transferring."
    end
  end
end
