class JobApplicationsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.create(job_application_params)
    if(@job_application.save)
      redirect_to job_path(@job)
    else
      redirect_to job_path(@job), notice: "You have already applied to this job"
	end
      
  end

  def destroy
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @job_application.destroy

    redirect_to job_path(@job)
  end

  private
    def job_application_params
      params.require(:job_application).permit(:applicant_username)
    end

end
