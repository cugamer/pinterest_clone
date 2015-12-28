require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  before(:all) do
    @user = build(:votes_user)
    @user.save
    @pin = build(:vote_pin)
    @pin.save
  end
  
  let(:user) { @user }
  let(:pin) { @pin }
  
  describe 'for logged in user' do
    it 'change_rating increases pin rating if user has not voted yet' do
      session[:user_id] = user.id
      
      expect(pin.reload.rating).to eq 0
      
      get :change_rating, :id => pin.id
      expect(pin.reload.rating).to eq 1
    end
    
    it 'change_rating decreases pin rating if user has already voted' do
      session[:user_id] = user.id
      
      expect(pin.reload.rating).to eq 0
      
      get :change_rating, :id => pin.id
      expect(pin.reload.rating).to eq 1
      
      get :change_rating, :id => pin.id
      expect(pin.reload.rating).to eq 0
    end
  end
  
  describe 'for non logged in users' do
    it 'change_rating redirects to the log in url' do
      get :change_rating, :id => pin.id
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end
  end
end
