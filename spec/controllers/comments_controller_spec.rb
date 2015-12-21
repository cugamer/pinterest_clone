require 'rails_helper'
require 'sessions_helper'

RSpec.describe CommentsController, type: :controller do
  it 'creates a new comment when given valid input' do
    pin = build(:pin)
    pin.save
    
    params = {:comment => {:pin_id => pin.id,
                            :comment_text => "comment"}}
                            
    user = build(:user)
    user.save
    
    session[:user_id] = user.id
    post(:create, params)
    expect(response).to render_template('pins/show')
    expect(response).to have_http_status(200)
  end
end
