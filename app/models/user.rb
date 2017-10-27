class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, 
    presence: true, 
    :format => {:with => /\A[0-9\w_]{4,20}\z/,
      message: "only allows letters or numbers and underscore 4-20 characters long."},
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
	
	validates_acceptance_of :terms_of_service,
	allow_nil: false
	
	attr_accessor :terms_of_service

  def to_param
    username
  end

end
