class Api::SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      token = user.create_tokens

      render json: { token: token }
    else
      raise ActiveRecord::RecordNotFound unless user
      head :unauthorized
    end
  end
end
