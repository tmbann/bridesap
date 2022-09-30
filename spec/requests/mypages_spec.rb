require 'rails_helper'

RSpec.describe "Mypages", type: :request do
  let(:user) { create(:user) }

  context "GET /api/mypage" do
    example "ログインしているユーザーはマイページに遷移できる" do
      token = login(user)
      get api_mypage_path, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end

    example "ログインしていないユーザーはマイページに遷移できない" do
      get api_mypage_path
      expect(response).to have_http_status(401)
    end
  end

  context "PATCH /api/mypage" do
    example "ログインしているユーザーはマイページを編集できる" do
      token = login(user)
      patch api_mypage_path, params: { user: { name: "test2", email: user.email, pre_shoot_date: "2022-06-03", wedding_date: "2022-10-08" }}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
    end

    example "ログインしていないユーザーはマイページを編集できない" do
      patch api_mypage_path, params: { user: { name: "test2", email: user.email, pre_shoot_date: "2022-06-03", wedding_date: "2022-10-08" }}
      expect(response).to have_http_status(401)
    end

    example "パラメーターが不正" do
      token = login(user)
      patch api_mypage_path, params: { user: { name: "", email: "", pre_shoot_date: "", wedding_date: "" }}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(400)
    end
  end
end