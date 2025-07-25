class UsersController < ApplicationController
  attr_reader :users

  before_action :require_admin, only: [ :index, :new, :create ]
  before_action :require_login, only: [ :show ] # Optional: add auth check for profile

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

  def new_pin
    @user = User.find(params[:id])
  end

  def set_pin
    user = current_user

    if user.pin.present?
      return render json: { error: "PIN already set" }, status: :unprocessable_entity
    end

    if params[:pin].blank?
      return render json: { error: "PIN can't be blank" }, status: :unprocessable_entity
    end

    user.update(pin: params[:pin])
    render json: { message: "PIN set successfully" }, status: :ok
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
