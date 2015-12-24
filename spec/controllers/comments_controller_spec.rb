require 'rails_helper'
require 'sessions_helper'

RSpec.describe CommentsController, type: :controller do
  
  describe 'for logged in users' do
    before(:each) do
      @user = build(:comments_user)
      @user.save
      session[:user_id] = @user.id
      @pin = build(:pin)
      @pin.save
    end
    
    let(:user) { @user }
    let(:pin) { @pin }
  
    it 'creates a new comment when given valid input' do
      params = {:comment => {:pin_id => pin.id,
                              :comment_text => "comment"}}
      
      expect(Comment.count).to be 0
      post(:create, params)
      expect(Comment.count).to be 1
      expect(response).to render_template('pins/show')
      expect(response).to have_http_status(200)
    end
    
  end
end
