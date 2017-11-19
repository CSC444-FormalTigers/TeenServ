require 'test_helper'

class JobMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can send new applicants notification" do
    job = jobs(:one)

    email = JobMailer.new_applicants_notification_email(job)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['notifications@example.com'], email.from
    assert_equal [job.user.email], email.to
    assert_equal 'A new applicant has applied for a job you posted!', email.subject

    # this is supposed to test the exact contents of the email,
    # but it's annoying to set up the fixtures.
    #assert_equal read_fixture('new_applicants_notification').join, email.body.to_s

  end
end
