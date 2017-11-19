class JobMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_applicants_notification_email(job)
    @user = job.user
    @job = job
    @url = job_url(job)
    mail(to: @user.email, subject: 'A new applicant has applied for a job you posted!')
  end

end
