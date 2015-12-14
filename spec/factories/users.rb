FactoryGirl.define do
  factory :user do
    name                  'John Smith'
    email                 'none@none.com'
    password              'password'
    password_confirmation 'password'
  end
end