require 'rails_helper'

# end
RSpec.describe StaticPagesHelper, type: :helper do
  describe 'formats title' do
    it 'yielding title body if nothing is passed' do
      expect(helper.formatted_title).to eq("Pinterest Clone")
    end
    
    it 'yielding input string plus bar plus title body' do
      expect(helper.formatted_title("test input")).to eq("test input | Pinterest Clone")
    end
  end
end
