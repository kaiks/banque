require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_transactions" do
    it "returns http success" do
      get :edit_transactions
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_accounts" do
    it "returns http success" do
      get :edit_accounts
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_user" do
    it "returns http success" do
      get :edit_user
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_user_transactions" do
    it "returns http success" do
      get :edit_user_transactions
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_user_accounts" do
    it "returns http success" do
      get :edit_user_accounts
      expect(response).to have_http_status(:success)
    end
  end

end
