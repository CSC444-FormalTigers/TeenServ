class JobApplicationsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.create(job_application_params)
    redirect_to job_path(@job)
  end

  private
    def job_application_params
      params.require(:job_application).permit(:applicant_username)
    end

end
