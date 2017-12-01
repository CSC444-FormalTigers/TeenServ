class JobsController < ApplicationController
  before_action :redirect_if_not_employer, only: [
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
    @jobs = Job.search(params[:services]).order(created_at: :desc)
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
    applicant_id = params[:job_application_id]
    query = @job.job_applications.where(:id => applicant_id)

    if !query.empty?
      job_app = query.last
      job_app.update_attribute(:is_accepted, true)

      begin
      JobMailer.application_accepted_notification_email(job_app).deliver_now
      rescue Net::SMTPAuthenticationError => e
        flash[:danger] = "Problem sending email notification to applicant."
      end

      redirect_to job_path(@job), notice: 'Accepted applicant!'
    else
      redirect_back root_url
    end
  end

  def unaccept_applicant
    @job = find_job_with_id
    applicant_id = params[:job_application_id]
    query = @job.job_applications.where(:id => applicant_id)

    if !query.empty?
      query.last.update_attribute(:is_accepted, false)
      redirect_to job_path(@job), notice: 'Unaccepted applicant!'
    else
      redirect_back root_url
    end
  end

  def pay_teenager
    @job = find_job_with_id

    worker_id = params[:worker_id]
    hours_worked = params[:hours_worked]
    worker = User.where(:id => worker_id).first
    employer = @job.user
    worker_pay = hours_worked.to_i * @job.hourly_pay
    #Hard coded percentage of what we get (10%)
    our_pay = (worker_pay * 1.10).round(2)

    @api = PayPal::SDK::AdaptivePayments.new
    @pay = @api.build_pay({
      :actionType => "PAY",
      :cancelUrl =>  job_url(@job),
      :currencyCode => "CAD",
      :feesPayer => "EACHRECEIVER",
      :receiverList => {
        :receiver => [{
          :amount => our_pay,
          :email => "teenserv-midway@gmail.com",
          :primary => true
        }, {
          :amount => worker_pay,
          :email => worker.email,
          :primary => false
        }
        ]
      },
      :returnUrl => job_url(@job)
    })

    @response = @api.pay(@pay)

    if @response.success? && @response.payment_exec_status != "ERROR"
      @response.payKey
      redirect_to @api.payment_url(@response)
    else
      flash[:error] = "There was an error with processing your payment. ERROR: " +
        @response.error[0].message
      redirect_to job_path(@job)
    end
  end

  private
    def job_params
      params.require(:job).permit(:username,
        :title,
        :description,
        :reocurring,
        :work_date,
        :response_deadline,
        :hourly_pay,
        :payment_method,
        :location,
        :is_accepting_applicants,
        :type_of_service)
    end

    def find_job_with_id
      Job.where(:id => params[:id]).first
    end

    def redirect_if_not_owner_or_admin
      @job = find_job_with_id
      @user = current_user
      if !(@job.username == @user.username) and !(@user.admin)
        redirect_to root_path
      end
    end
end
