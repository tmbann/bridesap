class Api::PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.find_by_email(params[:email])
    @user&.deliver_reset_password_instructions!
    head :ok
  end

  def edit
    user = User.load_from_reset_password_token(params[:id])
    render json: user
  end

  def update
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      head :ok
    else
      render json: @user.errors, status: :bad_request
    end
  end
end
