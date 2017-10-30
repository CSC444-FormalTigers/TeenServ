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

  test "cannot have duplicate job applications" do
    job = jobs(:one)
	job_application_1 = job.job_applications.create(applicant_username: "someUsername")
	assert job_application_1.save
	job_application_2 = job.job_applications.create(applicant_username: "someUsername")
    assert_not job_application_2.save
  end
  
  test "can apply to multiple jobs" do
    job_1 = jobs(:one)
	job_2 = jobs(:two)
	job_application_1 = job_1.job_applications.create(applicant_username: "someUsername")
	assert job_application_1.save
	job_application_2 = job_2.job_applications.create(applicant_username: "someUsername")
    assert job_application_2.save
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
