class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  mount_uploader :resume, ResumeUploader

  has_many :job_applications, dependent: :destroy
  has_many :jobs, dependent: :destroy

  # sent_reviews "names" the Review join table for accessing through the reviewer association
  has_many :sent_reviews, foreign_key: :reviewer_id, class_name: "Review", dependent: :destroy

  # received_reviews "names" the Review join table for accessing through the reviewee association
  has_many :received_reviews, foreign_key: :reviewee_id, class_name: "Review", dependent: :destroy


  def self.ACCOUNT_TYPES
    [ 
      'employer', 
      'teenager' 
    ]
  end


  validates :username,
    presence: true,
    :format => {:with => /\A[0-9\w_]{4,20}\z/,
      message: "only allows letters or numbers and underscore 4-20 characters long."},
    uniqueness: true

  validates :email,
    presence: true,
    :email_format => { :message => 'format is invalid.' },
    uniqueness: true

  validates :paypal_email,
    presence: true,
    :email_format => { :message => 'format is invalid.'},
    uniqueness: true,
    :unless => :employer?

  validates :age,
    :allow_blank => true,
    numericality: { only_integer: true, greater_than: 0, less_than: 200 }

  validates :gender,
    :allow_blank => true,
    :format => {:with => /((fe)?male|other)/i}

  validates :account_type,
    presence: true,
    inclusion: { in: self.ACCOUNT_TYPES }

  validates_acceptance_of :terms_of_service,
    allow_nil: false,
    on: :create

  validates :rating,
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}

  attr_accessor :terms_of_service



  def employer?
    return self.account_type == "employer"
  end

  def teenager?
    return self.account_type == "teenager"
  end

  def admin?
    return self.admin || self.super_admin
  end

end
