require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { User.create!(username: Faker::RickAndMorty.character, password: Faker::Pokemon.name) }
  describe "GET #index" do
    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) {nil}
      end

      it "redirects to log in page unless logged in" do
        get :index
        expect(response).to redirect_to(new_session_url)
      end
    end

    it "shows all the goals for a given user" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
