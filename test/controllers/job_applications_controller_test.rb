require 'test_helper'

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @job = jobs(:one)
    @user = users(:two)

    @job_application = job_applications(:one)
    @job_application.job = @job
    assert @job_application.save

  end


  test "can be created" do
    assert_difference 'JobApplication.count' do
      post job_job_applications_url(@job), params: {job_application: {
	      user_id: @user.id}}
#      post job_job_applications_url(@job), params: {job_application: {
#	      applicant_username: @job.username}}
    end
    assert_redirected_to job_url(@job)
  end

  test "can be deleted" do 
    assert_difference('JobApplication.count', -1) do
      delete job_job_application_url(@job, @job_application)
    end
    assert_redirected_to job_url(@job)
  end
end
