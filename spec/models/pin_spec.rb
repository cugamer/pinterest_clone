require 'rails_helper'

RSpec.describe Pin, type: :model do
  describe 'validations' do
    describe 'for title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(150) }
    end
    
    describe 'for description' do
      it { should validate_presence_of(:description) }
    end
    
    describe 'for user id' do
      it{ should validate_presence_of(:user_id) }
    end
    
    describe 'for rating' do
      it { should validate_presence_of(:rating)}
    end
    
    describe 'for presence' do
      it { should validate_presence_of(:pin_image).with_message("must be selected") }
    end
  end
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:votes) }
    it { should have_many(:comments).dependent(:destroy) }
  end
  
  describe 'rating default value should' do
    it do
      pin = Pin.new
      expect(pin.rating).to eq(0)
    end
  end
end
