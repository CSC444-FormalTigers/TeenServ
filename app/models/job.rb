class Job < ApplicationRecord
  has_many :job_applications

  validates :title, 
    presence: true
	
  validates :description, 
    presence: true
	
  validates :hourly_pay, 
    :numericality => {only_integer: true}


end
