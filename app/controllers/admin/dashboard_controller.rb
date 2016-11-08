class Admin::DashboardController < ApplicationController
  layout "admin"
  
  def index
  	login
  	@admin_articles= Admin::Article.all;
  end
end
