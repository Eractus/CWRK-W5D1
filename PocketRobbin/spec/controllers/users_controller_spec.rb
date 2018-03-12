require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new users template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
       it "signs the user in" do
         user_params = { username: Faker::RickAndMorty.character, password: Faker::Pokemon.name }
         post :create, params: { user: { username: user_params[:username], password: user_params[:password] } }
         user = User.find_by(username: user_params[:username])
         expect(session[:session_token]).to eq(user.session_token)
      end
    end

    context "with invalid params" do
      it "shows why you failed, making you a failure. FAILURE!!!" do
        user_params = { username: Faker::RickAndMorty.character }
        post :create, params: { user: { username: user_params[:username], password: user_params[:password] } }
        expect(flash[:errors]).to be_present
      end

      it "keeps you where failures belong. On the sign in page." do 
        user_params = { username: Faker::RickAndMorty.character }
        post :create, params: { user: { username: user_params[:username], password: user_params[:password] } }
        expect(response).to render_template(:new)
      end
    end
  end
end
