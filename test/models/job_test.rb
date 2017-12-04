require 'test_helper'

class JobTest < ActiveSupport::TestCase

  setup do
    @job = Job.new(new_job_params[:job])
  end

  test "can save a job" do
    assert @job.save
  end

  test "cannot save job without title" do
    orig_title = @job.title

    @job.title = nil
    assert_not @job.save, "Saved job without title"

    @job.title = orig_title
  end

  test "hourly pay can only be an float" do
    orig_hourly_pay = @job.hourly_pay

    @job.hourly_pay = "Not a number"
    assert_not @job.save, "Cannot save string as hourly pay"

    @job.hourly_pay = 20.44
    assert @job.save, "Can save float numbers"

    @job.hourly_pay = 13
    assert @job.save, "Can save integer numbers"

    @job.hourly_pay = orig_hourly_pay
  end

  test "hourly pay cannot be less than or equal to 0" do
    @job.hourly_pay = 0
    assert_not @job.save, "Cannot save job with pay equal to zero"

    @job.hourly_pay = -3
    assert_not @job.save, "Cannot save job with negative pay"
  end

  test "hourly pay cannot be greater than 999" do
    @job.hourly_pay = 1000
    assert_not @job.save, "Cannot save job with pay greater than 999"
  end

  test "deleting a user deletes its jobs" do
    user = users(:one)
    job = jobs(:one)
    job.user = user
    job.save

    assert user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { job.reload }

  end

  test "cannot have response deadline be later than work date" do
    @job.work_date = 1.days.from_now
    @job.response_deadline = 10.days.from_now
    assert_not @job.save, "Cannot save when response deadline later than work date"

  end

end
