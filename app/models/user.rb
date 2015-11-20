class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 55 }
  
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, length: { minimum: 6 }
  
  before_save { self.email = email.downcase }
  
  has_many :pins
  has_many :votes
  has_secure_password
end
