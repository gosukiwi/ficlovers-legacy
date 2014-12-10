class Admin::DashboardController < ApplicationController
  def index
    authorize Admin::Dashboard.new
  end
end
