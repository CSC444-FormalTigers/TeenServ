class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :user

  #validates :applicant_username,
  #  uniqueness: { scope: :job_id}
  
  validates :job_id,
    uniqueness: { scope: :user_id },
    presence: true
  
  validates :user_id,
    uniqueness: { scope: :job_id },
    presence: true

end
