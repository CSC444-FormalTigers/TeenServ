class TransactionsController < ApplicationController
  def destroy
  	@transaction = Transaction.last
  	if(@transaction != nil)
  	job_id = @transaction.service_id
  	@transaction.destroy
  	redirect_to job_path(job_id)
  	end
  end

  def show

  	if params[:account_type] == 'employer'
  		@transaction = Transaction.all.where("from_user = ?", params[:username])
  	elsif params[:account_type] == 'teenager'
  		@transaction = Transaction.all.where("to_user = ?", params[:username])
  	end

  end

end
