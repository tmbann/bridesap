module Api::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private

  def render_400
    render json: {
      errors: {
        title: 'Bad Request',
        detail: 'リクエストが不正です'
      }
    }, status: :bad_request
  end

  def render_404(error)
    if error.message == "[\"Emailはすでに存在します\"]"
      render json: {
        errors: {
          title: 'Record Not Found',
          detail: 'このメールアドレスはすでに登録されています'
        }
      }, status: :not_found
    else
      render json: {
        errors: {
          title: 'Record Not Found',
          detail: 'メールアドレスもしくはパスワードが正しくありません'
        }
      }, status: :not_found
    end
  end

  def render_500
    if ActiveRecord::RecordInvalid
      render json: {
        errors: {
          title: 'Internal Server Error',
          detail: '予期せぬエラーが発生しました'
        }
      }, status: :internal_server_error
    end
  end
end