class SuperadminController < ApplicationController
  def show
    @jobs = Job
    @users = User
    @job_applications = JobApplication
  end
end
