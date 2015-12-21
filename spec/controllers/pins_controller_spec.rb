require 'rails_helper'
include SessionsHelper

RSpec.describe PinsController, type: :controller do
  before(:all) do
    user = build(:user)
    user.save
    3.times do
      pin_params = FactoryGirl.attributes_for(:pin)
      pin = user.pins.create(pin_params)
    end
  end
  
  let(:user) { User.first }
  
  describe 'GET request to :new' do
    it 'renders the new pin view for logged in users' do
      log_in(user)
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
    
    it 'redirects non logged in user to login page' do
      get :new
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
  end
  
  describe 'POST request to :create' do
    it 'creates a new pin and redirects to the new pin' do
      log_in(user)

      pin_params = FactoryGirl.attributes_for(:pin)
      post :create, :pin => pin_params
      
      expect(response).to have_http_status(302)
      last = Pin.count
      expect(response).to redirect_to :action => :show,
                                      :id => last
    end
    
    it 'redirects non logged in user to login page' do
      pin_params = FactoryGirl.attributes_for(:pin)
      post :create, :pin => pin_params
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
  end
  
  describe 'GET request to edit' do
    it 'displays the edit view for logged in users' do
      log_in(user)

      pin = Pin.last
      
      get :edit, :id => pin.id
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
    
    it 'redirects non logged in user to login page' do
      pin = Pin.last
      
      get :edit, :id => pin.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
  end
end
