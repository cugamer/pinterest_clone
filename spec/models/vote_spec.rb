require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:pin) }
  end
  
  describe 'validations' do
    describe 'for user id' do
      it { should validate_presence_of(:user_id) }
    end
    
    describe 'for pin id' do
      it { should validate_presence_of(:pin_id) }
    end
  end
end
