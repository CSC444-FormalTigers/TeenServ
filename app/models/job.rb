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
    :numericality => {only_float: true, greater_than: 0, less_than_or_equal_to: 999}

  validates :location,
    presence: true

  validates :type_of_service,
    inclusion: {in:self.services}

  validates :work_date,
    presence: true

  validates :response_deadline,
    presence: true

  validate :response_deadline_cannot_be_later_than_work_date

  def self.search(services)
    if services
      where(type_of_service: services)
    else
      all
    end
  end


  private

  def response_deadline_cannot_be_later_than_work_date
    if response_deadline.present? && response_deadline > work_date
      errors.add(:response_deadline, "Can't be later than the work date.")
    end
  end

end
