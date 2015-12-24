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
  
  factory :sessions_user, :parent => :user do
    name                  'Red Green'
    email                 'none2@none.com'
  end
  
  factory :users_mod_user, :parent => :user do
    name                  'Han Solo'
    email                 'none3@none.com'
  end
end