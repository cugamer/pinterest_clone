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
  
  factory :comments_user, :parent => :user do
    name                  'Guy Icognito'
    email                 'none5@none.com'
  end
  
  factory :no_account_user, :parent => :user do
    name                  'Jason Bourne'
    email                 'none6@none.com'
  end
  
  factory :users_cont_user, :parent => :user do
    name                  'Martin VanNostren'
    email                 'none7@none.com'
  end
  
  factory :users_cont_user_two, :parent => :user do
    name                  'William Riker'
    email                 'none8@none.com'
  end
  
  factory :users_cont_user_three, :parent => :user do
    name                  'Hawkeye Pierce'
    email                 'none9@none.com'
  end
  
  factory :users_cont_user_edit, :parent => :user do
    name                  'Wesley Crusher'
    email                 'none8edited@none.com'
  end
  
  factory :votes_user, :parent => :user do
    name                  'Harry S Plinket'
    email                 'none9@none.com'
  end
  
  factory :users_cont_user_edit_invalid, :parent => :user do
    name                  ''
    email                 'none.com'
  end
  
  factory :invalid_user, :parent => :user do
    name                  ''
    email                 'none@'
    password              'password'
    password_confirmation 'password_no_match'
  end
end