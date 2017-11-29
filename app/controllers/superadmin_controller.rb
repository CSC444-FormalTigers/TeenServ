class SuperadminController < ApplicationController
  def show
    @jobs = Job
    @users = User
    @job_applications = JobApplication
    @changelogs = Changelog
    @endorsements = Endorsement
    @reviews = Review
    @skills = Skill
    @teenagers = Teenager
    @transactions = Transaction
  end
end
