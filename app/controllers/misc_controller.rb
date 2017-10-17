class MiscController < ApplicationController
  skip_before_action :authenticate_user!, 
    only: [:about, 
      :terms, 
      :policy, 
      :contact, 
      :faq]

  def about
  end
  def terms
  end
  def policy
  end
  def contact
  end
  def faq
  end
end
