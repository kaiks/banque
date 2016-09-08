require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when not logged in' do

    end

    context 'when logged in' do
      it 'redirects to #dashboard'
    end
  end

end
