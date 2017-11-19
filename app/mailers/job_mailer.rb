class JobMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_applicants_notification_email(job)
    @user = job.user
    @job = job
    @url = job_url(@job)
    mail(to: @user.email, subject: 'A new applicant has applied for a job you posted!')
  end

  def application_accepted_notification_email(job_application)
    @user = job_application.user
    @job = job_application.job
    mail(to: @user.email, subject: 'An application for a job has been accepted!')

  end

end
