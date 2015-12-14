require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'creation' do
    it "is successful when given valid inputs" do
      expect(build(:comment)).to be_valid
    end
  end
  
  describe 'validates' do
    describe 'user id' do
      it { should validate_presence_of(:user_id) }
    end
    
    describe 'pin id' do
      it { should validate_presence_of(:pin_id) }
    end
    
    describe 'comment text' do
      it { should validate_presence_of(:comment_text) }
    end
  end
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:pin) }
  end
end
