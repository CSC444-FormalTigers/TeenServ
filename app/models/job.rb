class Job < ApplicationRecord

  validates :title, 
    presence: true
	
  validates :description, 
    presence: true
	
  validates :hourly_pay, 
    :numericality => {only_integer: true}


end
