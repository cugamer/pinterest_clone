class Pin < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true
  validates :user_id, presence: true
  validates :rating, presence: true
  validates :pin_image, presence: { :message => "must be selected" }
  
  default_value_for :rating, 0
  
  belongs_to :user
  has_many :votes
  has_many :comments, dependent: :destroy
  
  mount_uploader :pin_image, PinImageUploader
end
