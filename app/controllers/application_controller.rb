class ApplicationController < ActionController::Base
  include Api::UserAuthenticator
  include Api::ExceptionHandler

  protect_from_forgery with: :null_session
  before_action :require_login

  def not_authenticated
    redirect_to main_app.admin_login_path, notice: 'ログインしてください'
  end
end
