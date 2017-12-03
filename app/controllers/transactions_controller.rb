class TransactionsController < ApplicationController
  def show

  	if params[:account_type] == 'employer'
  		@transaction = Transaction.all.where("from_user = ?", params[:username])
  	elsif params[:account_type] == 'teenager'
  		@transaction = Transaction.all.where("to_user = ?", params[:username])
  	end
  		
  end
end
