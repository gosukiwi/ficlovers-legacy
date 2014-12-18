class Admin::AdminController < ApplicationController
  before_action ->{ redirect_to login_url unless admin?  }
end
