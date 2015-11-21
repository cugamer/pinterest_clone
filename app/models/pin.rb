class Pin < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true
  validates :user_id, presence: true
  validates :rating, presence: true
  
  default_value_for :rating, 0
  
  belongs_to :user
  has_many :votes
  has_many :comments
  
  mount_uploader :pin_image, PinImageUploader
end
