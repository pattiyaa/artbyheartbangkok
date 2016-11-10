class HomeController < ApplicationController
  def index
  	@articles_hightlight = Admin::Article.all
  	@articles_hightlight = getArticlesImg(@articles_hightlight)
  
  end
end
