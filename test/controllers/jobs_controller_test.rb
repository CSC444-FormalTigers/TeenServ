require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @job_owner = users(:two)
    @admin_user = users(:admin)

    @job = jobs(:one)

    @job_application = job_applications(:one)
    @job_application.job = @job
    assert @job_application.save
  end

  test "can get index of jobs" do
    get jobs_url
    assert_response :success
  end


  test "can't get jobs when not logged in" do
    sign_out @user
    get jobs_url
    assert_redirected_to new_user_session_url
    sign_in @user
  end


  test "can't create a job while not logged in" do
    sign_out @user

    assert_no_difference('Job.count') do
      post jobs_url, params: {job: {
        username: "PossibleUserName",
        title: "Some Title",
        description: "Some Description",}}
    end
    assert_redirected_to new_user_session_url

    sign_in @user
  end


  test "can create a job" do
    assert_difference('Job.count') do
      post jobs_url, params: {job: {
        username: "PossibleUserName",
        title: "Some Title",
        description: "Some Description",
		hourly_pay: "10",
    payment_method: "Credit"}}
    end

    assert_redirected_to job_url(Job.last)
    assert_equal 'Some Title', Job.last.title
  end


  test "can't show job when not signed in" do
    sign_out @user
    get job_url(@job)
    assert_redirected_to "/users/sign_in"
    sign_in @user
  end


  test "can show a job" do
    get job_url(@job)
    assert_response :success
  end

  test "can edit job" do
    sign_out @user
    sign_in @job_owner
    get edit_job_path(@job)
    assert_response :success
    sign_out @job_owner
    sign_in @user
  end

  test "can't edit job if not logged in" do
    sign_out @user
    get edit_job_path(@job)
    assert_redirected_to new_user_session_url
    sign_in @user
  end

  test "can't edit job if not job creator or admin" do
    get edit_job_path(@job)
    assert_redirected_to root_path
  end

  test "can delete job" do
    sign_out @user
    sign_in @job_owner
    assert_difference 'Job.count', -1 do
      delete job_url(@job)
    end
    assert_redirected_to jobs_path
    sign_out @job_owner
    sign_in @user
  end

  test "can't delete job if not logged in" do
    sign_out @user
    delete job_url(@job)
    assert_redirected_to new_user_session_url
    sign_in @user
  end

  test "can't delete job if not job creator or admin" do
    delete job_url(@job)
    assert_redirected_to root_path
  end


  test "can accept job application" do
    patch accept_applicant_job_url(@job, :job_application_id => @job_application.id)
    assert_redirected_to job_path(@job)

    @job_application.reload
    assert(@job_application.is_accepted)
  end

end
