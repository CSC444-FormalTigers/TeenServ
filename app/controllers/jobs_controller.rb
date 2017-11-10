class JobsController < ApplicationController
  before_action :redirect_if_not_client, only: [
    :create,
    :new,
    :update,
    :edit,
    :destroy
  ]

  before_action :redirect_if_not_owner_or_admin, only: [
    :update,
    :edit,
    :destroy
  ]

  def index
    @jobs = Job.search(params[:search])
  end

  def create
    @job = current_user.jobs.create(job_params)

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


  def accept_applicant
    @job = find_job_with_id

    redirect_to job_path(@job), notice: 'Accepted applicant!'
  end


  private
    def job_params
      params.require(:job).permit(:username,
        :title, 
        :description, 
        :reocurring, 
        :work_date,
        :response_deadline, 
        :hourly_pay)
    end

    def find_job_with_id
      @job = Job.where(:id => params[:id]).first
    end

    def redirect_if_not_owner_or_admin
      @job = find_job_with_id
      @user = current_user
      if !(@job.username == @user.username) and !(@user.admin)
        redirect_to root_path
      end
    end
end
