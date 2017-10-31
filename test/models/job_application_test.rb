require 'test_helper'

class JobApplicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can save a job application" do
    job = jobs(:one)
    user = users(:two)
    job_application = JobApplication.new({
	    job_id: job.id,
	    user_id: "user.id"})
    assert job_application.save
  end

  test "cannot have duplicate job applications" do
    job = jobs(:one)
    user = users(:two)
    job_application_1 = job.job_applications.create(user_id: user.id)
    assert job_application_1.save
    job_application_2 = job.job_applications.create(user_id: user.id)
    assert_not job_application_2.save
  end
  
  test "can apply to multiple jobs" do
    job_1 = jobs(:one)
    job_2 = jobs(:two)
    user = users(:one)
    job_application_1 = job_1.job_applications.create(user_id: user.id)
    assert job_application_1.save
    job_application_2 = job_2.job_applications.create(user_id: user.id)
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
  
  test "deleting a user deletes its applications" do
    user = users(:one)
    job_application = job_applications(:one)
    job_application.user = user
    job_application.save

    assert user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { job_application.reload }
  end

end
