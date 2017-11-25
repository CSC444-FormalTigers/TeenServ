require 'test_helper'

class JobTest < ActiveSupport::TestCase

  setup do
    @job = Job.new
    @job.title = "Some title"
    @job.description = "Some description"
    @job.hourly_pay = 13
    @job.payment_method = "Credit"
    @job.location = "Some Location"
    @job.type_of_service = "other (please specify in description)"
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

  test "hourly pay can only be an integer" do
    orig_hourly_pay = @job.hourly_pay

    @job.hourly_pay = "Not a number"
    assert_not @job.save, "Cannot save string as hourly pay"

    @job.hourly_pay = 20.44
    assert_not @job.save, "Cannot save non integer numbers"

    @job.hourly_pay = 13
    assert @job.save

  end

  test "deleting a user deletes its jobs" do
    user = users(:one)
    job = jobs(:one)
    job.user = user
    job.save

    assert user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { job.reload }

  end

end
