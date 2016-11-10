class Admin::DashboardController < ApplicationController
  layout "admin"
  
  def index
  	login
  	
  end
end
