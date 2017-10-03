class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true
  validates :email, 
    presence: true, 
    :email_format => { :message => 'format is invalid.' }
end
