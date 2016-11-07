class Admin::DashboardController < ApplicationController
  layout "admin"
  def index
  	loginid = 1
  	@admin_user = Admin::User.find(loginid)
  	@admin_user_photo = Admin::Photo.find_by( imageable_id: loginid,imageable_type: "user")
  	@admin_articles= Admin::Article.all;
  end
end
