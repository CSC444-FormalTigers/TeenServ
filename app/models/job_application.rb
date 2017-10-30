class JobApplication < ApplicationRecord
  belongs_to :job

  validates :applicant_username,
    uniqueness: { scope: :job_id}

end
