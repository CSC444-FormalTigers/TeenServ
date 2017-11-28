class JobApplicationsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    
    if @job.is_accepting_applicants
      @job_application = @job.job_applications.create(job_application_params)

      if(@job_application.save)
        begin
        JobMailer.new_applicants_notification_email(@job).deliver_now
        rescue Net::SMTPAuthenticationError => e
          flash[:success] = "Problem sending email notification to job owner."
        end

        redirect_to job_path(@job), notice: "Successfully applied for this job"
      else
        render job_path(@job), notice: "You have already applied to this job"
      end

    else
      redirect_to job_path(@job), notice: "Job is not accepting more applicants."
    end
      
  end

  def destroy
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @job_application.destroy

    redirect_to job_path(@job), notice: 'Deleted a job application'
  end

  private
    def job_application_params
      params.require(:job_application).permit(:user_id)
    end

end
