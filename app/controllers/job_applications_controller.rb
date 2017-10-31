class JobApplicationsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    #@job_application = @job.job_applications.create(job_application_params)
    @job_application = @job.job_applications.create(job_application_params)
    #puts :user_id
    #@job_application = JobApplication.new(job_application_params) 
    if(@job_application.save)
      #redirect_to job_path(@job)
      @notice_string = "Successfully applied for this job"
    else
      @notice_string = "You have already applied to this job"
      #redirect_to job_path(@job), notice: "You have already applied to this job"
    end
    redirect_to job_path(@job), notice: @notice_string
      
  end

  def destroy
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @job_application.destroy

    redirect_to job_path(@job)
  end

  private
    def job_application_params
      #params.require(:job_application).permit(:applicant_username)
      #params.require(:job_application).permit(:job_id, :user_id)
      params.require(:job_application).permit(:user_id)
    end

end
