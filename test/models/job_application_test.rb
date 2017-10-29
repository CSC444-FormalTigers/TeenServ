require 'test_helper'

class JobApplicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can save a job application" do
    job_application = JobApplication.new({
            applicant_username: "someUsername"})
    assert job_application.save
  end
end
