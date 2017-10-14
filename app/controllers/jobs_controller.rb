class JobsController < ApplicationController
  def index
    @job = Job.all
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to @job, notice: 'Created Job!'
    else
      render 'new'
    end
  end

  def update
    @job = find_job_with_id

    if @job.update(job_params)
      redirect_to @job, notice: 'Updated Job!'
    else
      render 'edit'
    end
  end

  def new
    @job = Job.new
  end

  def show
    @job = find_job_with_id
  end

  def edit
    @job = find_job_with_id
  end

  def destroy
    @job = find_job_with_id
    @job.destroy

    redirect_to jobs_path, notice: 'Deleted Job!'
  end

  private
    def job_params
      params.require(:job).permit(:username,
      :title, :description, :reocurring, :work_date,
      :response_deadline, :hourly_pay)
    end

    def find_job_with_id
      @job = Job.where(:id => params[:id]).first
    end
end
