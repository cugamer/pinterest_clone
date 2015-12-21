require 'rails_helper'
include SessionsHelper

RSpec.describe PinsController, type: :controller do
  describe 'GET request to :new' do
    it 'renders the new pin view' do
      user = build(:user)
      user.save
      log_in(user)
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET request to :create' do
    it 'creates a new pin and redirects to the new pin' do
      user = build(:user)
      user.save
      log_in(user)

      
      pin_params = FactoryGirl.attributes_for(:pin)
      post :create, :pin => pin_params
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to :action => :show,
                                      :id => 1
    end
  end
end
