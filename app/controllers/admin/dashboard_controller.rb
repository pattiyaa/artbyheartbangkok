class Admin::DashboardController < ApplicationController
  def index
  	@admin_user = Admin::User.find(1)
  	@admin_articles= Admin::Article.all;
  end
end
