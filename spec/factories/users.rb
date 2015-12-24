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
  
  factory :sessions_cont_user, :parent => :user do
    name                  'Nerf Hearder'
    email                 'none4@none.com'
  end
  
  factory :no_account_user, :parent => :user do
    name                  'Jason Bourne'
    email                 'none5@none.com'
  end
end