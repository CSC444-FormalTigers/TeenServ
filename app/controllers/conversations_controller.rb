class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]


  def index
    @conversations = @mailbox.inbox
  end
  
  def new
  end
  
  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
  
  def show
  end

  private
  
  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
  
  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end
end