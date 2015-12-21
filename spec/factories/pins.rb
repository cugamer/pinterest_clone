FactoryGirl.define do
  factory :pin do
    title                   "Pin title"
    description             "Descriptive text"
    user_id                 1

    pin_image               Rack::Test::UploadedFile.new(Rails.root.join("spec/features/kitty.jpg"))
  end
end