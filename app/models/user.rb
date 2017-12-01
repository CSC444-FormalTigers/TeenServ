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

  validates :username,
    presence: true,
    :format => {:with => /\A[0-9\w_]{4,20}\z/,
      message: "only allows letters or numbers and underscore 4-20 characters long."},
    uniqueness: true

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
    :format => {:with => /employer|teenager/i}

  validates_acceptance_of :terms_of_service,
    allow_nil: false,
    on: :create

  attr_accessor :terms_of_service

  def mailboxer_email(object)
  #currently not implemented
	return nil
  end

end
