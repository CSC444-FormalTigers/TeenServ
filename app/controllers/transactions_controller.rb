class TransactionsController < ApplicationController
  def destroy
  	@transaction = Transaction.where(id: params[:tran_id]).first
    if @transaction != nil
      job_id = @transaction.service_id
      @transaction.destroy
      redirect_to job_path(job_id)
    else
      redirect_to root_path
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
