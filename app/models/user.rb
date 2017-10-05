class User < ApplicationRecord
  has_secure_password

  validates :username, 
    presence: true, 
    uniqueness: true

  validates :password, 
    presence: true

  validates :email,
    presence: true,
    :email_format => { :message => 'format is invalid.' },
    uniqueness: true

  def to_param
    username
  end
  
end
