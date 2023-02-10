require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/members/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/members/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/members/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
