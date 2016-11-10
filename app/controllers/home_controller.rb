class HomeController < ApplicationController
  layout "plain"
  def index
  	@articles_highlight = Admin::Article.where(:isToplist => true)
  	@articles_highlight = getArticlesImg(@articles_highlight)
  end
end
