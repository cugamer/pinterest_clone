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
  end
  
  let(:user1) { User.find(1) }
  let(:user2) { User.find(2) }
  
  after(:all) do
    user1.destroy
    user2.destroy
  end
  
  let(:updated_title) { "Updated title" }
  let(:updated_desc) { "Updated description" }
  let(:updated_pic) { "kitty_update.jpg" }
  
  def update_pin_info(pin)
    patch :update, { :id => pin.id, :pin => {:title => "Updated title",
                      :description => updated_desc,
                      :pin_image => Rack::Test::UploadedFile.new(Rails.root.join("spec/features/#{updated_pic}"))}}
  end
  
  describe 'for all users' do
    it 'navigating to a pin url displays the pin page' do
      get :show, :id => 1
      
      expect(response).to have_http_status(200)
      expect(response).to render_template('show')
    end
    
    it 'navigationg to a url for a non existant pin renders the pin not found page' do
      get :show, id: 5000
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:no_pin)
    end
    
    it 'navigating to a users pins page renders the show_user view for that user' do
      get :show_user, user_id: 1
      
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show_user)
    end
  end
  
  describe 'for logged in users' do
    before(:each) { log_in(user1) }
    
    it 'GET request to :new renders the new pin view' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
    
    it 'POST request to create creates a new pin and redirects to the new pin' do
      pin_params = FactoryGirl.attributes_for(:pin)
      last = Pin.count
      post :create, :pin => pin_params
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to :action => :show, :id => last + 1
    end
    
    it 'GET response to edit displays the edit view' do
      pin = Pin.last
      
      get :edit, :id => pin.id
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
    
    it 'PUT request to update updates values and redirects to the pin page' do
      pin = Pin.first
      
      update_pin_info(pin)
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:action => :show, :id => pin.id)
      expect(Pin.first[:title]).to eq updated_title
      expect(Pin.first[:description]).to eq updated_desc
      expect(Pin.first[:pin_image]).to eq updated_pic
    end
    
    it 'DELETE request to destroy removes pins and redirects to the users pin page' do
      pin_count = user1.pins.count
      pin = user1.pins.last
      
      delete :destroy, id: pin
      
      expect(user1.pins.count).to eq(pin_count - 1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:action => :show_user, :user_id => user1.id)
    end
  end
  
  describe 'for non logged in users' do
    it 'GET request to :new redirects to login page' do
      get :new
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
    
    it 'POST request to :create redirects to login page' do
      pin_params = FactoryGirl.attributes_for(:pin)
      post :create, :pin => pin_params
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
    
    it 'GET request to edit redirects to login page' do
      pin = Pin.last
      
      get :edit, :id => pin.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
    
    it 'Put request to update redirects to sign in page' do
      pin = Pin.first

      patch :update, { :id => pin.id, :pin => {:title => "Updated title",
                      :description => updated_desc,
                      :pin_image => Rack::Test::UploadedFile.new(Rails.root.join("spec/features/#{updated_pic}"))}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
    
    it 'DELETE request to destroy has no effect and redirects to log in view' do
      pin_count = user1.pins.count
      pin = user1.pins.last
      
      delete :destroy, id: pin
      
      expect(user1.pins.count).to eq(pin_count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:login)
    end
  end
  
  describe 'For logged in but invalid users' do
    behavior = "redirects to the root page"
    
    before(:each) { log_in(user2) }
    
    it "GET request to edit #{behavior}" do
      pin = Pin.first
      
      get :edit, :id => pin.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
    end
    
    it "PUT reques to update #{behavior}" do
      pin = Pin.first
      update_pin_info(pin)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
    end
    
    it 'DELETE request to destroy has no effect and redirects to root view' do
      pin_count = user1.pins.count
      pin = user1.pins.last
      
      delete :destroy, id: pin
      
      expect(user1.pins.count).to eq(pin_count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(:root)
    end
  end
end
