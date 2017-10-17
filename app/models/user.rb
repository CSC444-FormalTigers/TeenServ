class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, 
    presence: true, 
    uniqueness: true

  validates :password, 
    presence: true

  validates :email,
    presence: true,
    :email_format => { :message => 'format is invalid.' },
    uniqueness: true

  validates :age, 
    :allow_blank => true,
    numericality: { only_integer: true, greater_than: 0, less_than: 200 }
    
  validates :gender,
    :allow_blank => true,
    :format => {:with => /((fe)?male|other)/i}

  validates :account_type,
    presence: true,
    :format => {:with => /client|teenager/i}

  def to_param
    username
  end
  
end
