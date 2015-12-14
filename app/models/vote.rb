class Vote < ActiveRecord::Base
  belongs_to :pin
  belongs_to :user
  
  validates :pin_id, presence: true
  validates :user_id, presence: true
end
