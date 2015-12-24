require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:context) do
    @user = build(:sessions_cont_user)
    @user.save
  end
  
  let(:user) { @user }
  
  it 'navigating to log in page displays log in view' do
    get(:new)
    
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end
  
  describe 'sessions create' do
    it 'creates a session and redirects to users pin page on successful log in' do
      user_params = FactoryGirl.attributes_for(:sessions_cont_user)
      post :create, :session => user_params
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to "/user_pins/#{user.id}"
      expect(session[:user_id]).to eq(user.id)
    end
    
    it 'renders the login page on a failed log in' do
      user_params = FactoryGirl.attributes_for(:no_account_user)
      post :create, :session => user_params
      
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
      expect(flash.now[:danger]).to eq("Username or password is incorrect.")
    end
  end
  
  describe 'sessions destroy' do
    it 'destroys session and redirects to root url on log out' do
      user_params = FactoryGirl.attributes_for(:sessions_cont_user)
      post :create, :session => user_params
      
      delete :destroy

      expect(session[:user_id]).to be nil
      expect(response).to have_http_status(302)
      expect(response).to redirect_to "/"
    end
  end
end
