class MiscController < ApplicationController
  skip_before_action :authenticate_user!, 
    only: [:terms, 
      :policy, 
      :contact, 
      :faq]

  def terms
  end
  def policy
  end
  def contact
  end
  def faq
  end
end
