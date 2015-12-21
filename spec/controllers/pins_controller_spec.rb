require 'rails_helper'
include SessionsHelper

RSpec.describe PinsController, type: :controller do
  before(:all) do
    user1 = build(:user)
    user2 = build(:user_two)
    user1.save
    user2.save
    3.times do
      pin_params = FactoryGirl.attributes_for(:pin)
      pin = user1.pins.create(pin_params)
    end
    p User.all
  end
  
  let(:user1) { User.find(1) }
  let(:user2) { User.find(2) }
  
  describe 'GET request to :new' do
    it 'renders the new pin view for logged in users' do
      log_in(user1)
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
      log_in(user1)

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
      log_in(user1)

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
    
    it 'redirects wrong logged in user to root page' do
      log_in(user2)
      pin = Pin.first
      
      get :edit, :id => pin.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
    end
  end
end
