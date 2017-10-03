class User < ApplicationRecord
  has_secure_password

  def to_param
    username
  end
  
  validates :username, presence: true
  validates :password, presence: true
  validates :email,
    presence: true,
    :email_format => { :message => 'format is invalid.' }
end
