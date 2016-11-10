class HomeController < ApplicationController
  layout "plain"
  def index

  	@articles_highlight = Admin::Article.where(:isToplist => true).order(updated_at: :desc).limit(10)
  	@articles_highlight = getArticlesImg(@articles_highlight)
  end
end
