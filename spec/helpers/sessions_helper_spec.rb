require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { build(:user) }
  
  describe 'log_in method' do
    it "creates a user_id value in the session object" do
      user.save
      helper.log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end
  
  describe 'when logged in' do
    before(:example) do 
      user.save
      helper.log_in(user) 
    end
    
    it 'returns the user when logged in' do
      expect(helper.current_user).to eq(user)
    end
    
    it 'return true when user is logged in' do
      expect(helper.logged_in?).to be(true)
    end
    
    it 'sets the correct values on logout' do
      expect(helper.current_user).to eq(user)
      expect(session[:user_id]).to eq(user.id)
      helper.logout
      expect(helper.current_user).to be(nil)
      expect(session[:user_id]).to be(nil)
    end
  end
  
  describe 'when not logged in' do
    it 'current_user is nill' do
      expect(helper.current_user).to be(nil)
    end
    
    it 'logged_in? returns false' do
      expect(helper.logged_in?).to be(false)
    end
  end
end
