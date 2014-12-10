class Admin::DashboardController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Admin::Dashboard.new
  end
end
