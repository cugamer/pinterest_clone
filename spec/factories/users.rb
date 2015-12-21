FactoryGirl.define do
  factory :user do
    name                  'John Smith'
    email                 'none@none.com'
    password              'password'
    password_confirmation 'password'
  end
  
  factory :user_two, :parent => :user do
    name                  'Jane Smith'
    email                 'none1@none.com'
  end
end