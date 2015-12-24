require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'navigating to' do
    it 'root url displays the root page' do
      get(:home)
      
      expect(response).to have_http_status(200)
      expect(response).to render_template(:home)
    end
    
    it 'help url displays the help page' do
      get(:help)
      
      expect(response).to have_http_status(200)
      expect(response).to render_template(:help)
    end
    
    it 'no pin url displays the no pin page' do
      get(:no_pin)
      
      expect(response).to have_http_status(200)
      expect(response).to render_template(:no_pin)
    end
  end
end
