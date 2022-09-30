require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  context "POST /api/users" do
    example "パラメータが正常である" do
      post api_users_path(params: { user: { name: "test1", email: "test@example.com", password: "password", password_confirmation: "password" } })
      expect(response).to have_http_status(200)
      expect(1).to eq(User.count)
    end

    example "パラメーターの名前とメールアドレスが不正" do
      post api_users_path(params: { user: { name: "", email: "", password: "password", password_confirmation: "password" } })
      expect(response).to have_http_status(404)
      expect(0).to eq(User.count)
    end

    example "パラメーターのパスワードが不正" do
      post api_users_path(params: { user: { name: "test1", email: "test@example.com", password: "", password_confirmation: "" } })
      expect(response).to have_http_status(404)
      expect(0).to eq(User.count)
    end

    example "パラメーターのメールアドレスが既に登録済みである" do
      post api_users_path(params: { user: { name: "test2", email: user.email, password: "password", password_confirmation: "password"} })
      expect(response).to have_http_status(404)
      expect(1).to eq(User.count)
    end
  end
end