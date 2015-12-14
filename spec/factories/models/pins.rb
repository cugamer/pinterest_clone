FactoryGirl.define do
  factory :pin do
    title                   "Pin title"
    description             "Descriptive text"
    user_id                 1
    pin_image               File.open(File.join(Rails.root,
                                                '/spec/features/kitty.jpg'))
  end
end