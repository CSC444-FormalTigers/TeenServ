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

  test "deleting a job deletes its applications" do
    job = jobs(:one)
    job_application = job_applications(:one)
    job_application.job = job
    job_application.save

    assert job.destroy
    assert_raise(ActiveRecord::RecordNotFound) { job_application.reload }
  end

end
