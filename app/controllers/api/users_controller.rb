class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[me]
  skip_before_action :require_login

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :ok
    else
      raise ActiveRecord::RecordNotFound, @user.errors.full_messages
    end
  end

  def me
    render json: login_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :pre_shoot_date, :wedding_date)
  end
end
