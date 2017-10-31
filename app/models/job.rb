class Job < ApplicationRecord
  has_many :job_applications, dependent: :destroy

  validates :title, 
    presence: true
	
  validates :description, 
    presence: true
	
  validates :hourly_pay, 
    :numericality => {only_integer: true}

	def self.search(search)
	  if search
	    where('description LIKE ?', "%#{search}%")
	  else
	    all
	  end
	end

end
