class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  def index
    @Jobs = Job.all
    @average_wage = Job.average(:hourly_pay)
    @Users = User.all
  end
end
