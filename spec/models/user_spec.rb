require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'for name' do
      it { should validate_presence_of(:name) }
      
      it { should validate_length_of(:name).is_at_most(55) }
    end
    
    describe 'for email' do
      it { should validate_presence_of(:email) }
      
      it { should validate_length_of(:email).is_at_most(255) }
      
      it do
        should allow_values('none@none.com',
                            '1111@22222.3333',
                            '1a1a1a@2b2b2b2.3c3c3c')
          .for(:email)
      end
      
      it do
        should_not allow_values('none',
                                'none@none',
                                'none.com',
                                'none@none..com',
                                '@none.com',
                                '.com')
          .for(:email)
      end
      
      it do 
        # pending("Not sure how to work this")
        should validate_uniqueness_of(:email).case_insensitive  
      end
    end
    
    describe 'for password' do
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end
  
  describe 'on account creation' do
    it 'is created when given correct inputs' do
      expect(build(:user)).to be_valid
    end
    
    describe 'password' do
      it { should have_secure_password }
    end
    
    describe 'email' do
      it 'should be downcased when saved' do
        User.create(name:                  "John Smith",
                    email:                 "NONE@NONE.COM",
                    password:              "password",
                    password_confirmation: "password")
                    
        user = User.find_by(name: "John Smith")
        expect(user.email).to eq("none@none.com")
        user.destroy # Really not sure why this is necessary, but the new account
                     # is sticking around for some reason if not included.
      end
    end
  end
  
  describe 'associations' do
    it { should have_many(:pins).dependent(:destroy) }
    it { should have_many(:votes) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
