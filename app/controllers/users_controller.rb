class UsersController < ApplicationController
  before_action :require_admin, only: [:index, :new, :create]
  before_action :require_login, only: [:show] # Optional: add auth check for profile

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(
      :account_no, :name, :email, :phone_number,
      :password, :password_confirmation,
      :role, :account_type, :balance
    )
  end

  def require_login
    redirect_to login_path, alert: "Please login first." unless current_user
  end
end
