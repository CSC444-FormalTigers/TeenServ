class Job < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy

  def self.services
    [
      'babysitting',
      'yard work',
      'snow shoveling',
      'furniture moving',
      'simple cleaning tasks',
      'out of town services',
      'dog walking',
      'computer help',
      'tutoring',
      'other (please specify in description)'
    ]
  end

  validates :title,
    presence: true

  validates :description,
    presence: true

  validates :hourly_pay,
    :numericality => {only_integer: true}

  validates :payment_method,
    presence: true

  validates :location,
    presence: true

  validates :type_of_service,
    inclusion: {in:self.services}

  validates :work_date,
    presence: true

  validates :response_deadline,
    presence: true

  def self.search(services)
    if services
      where(type_of_service: services)
    else
      all
    end
  end

  
  private


  def incorrect_response_deadline_check
  end

end
