class Api::MypagesController < ApplicationController
  before_action :authenticate!
  before_action :set_user

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :pre_shoot_date, :wedding_date)
  end
end
