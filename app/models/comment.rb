class Comment < ActiveRecord::Base
  validates :user_id, presence: true
  validates :pin_id, presence: true
  validates :comment_text, presence: true
  
  belongs_to :user
  belongs_to :pin
end
