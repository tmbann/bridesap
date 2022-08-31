class Admin::SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to rails_admin_path
    else
      flash.now[:alert] = 'ログイン情報が正しくありません'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
