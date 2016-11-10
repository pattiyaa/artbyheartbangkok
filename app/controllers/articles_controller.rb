class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index

  
  end
  def show
    
    @article.coverphoto = Admin::Photo.find_by( imageable_id: @article.id,imageable_type: "article_cover")
  	@articles_highlight = Admin::Article.where(:isToplist => true, :category => @article.category) 
    @articles_highlight = @articles_highlight.where.not(:id => @article.id)
    @articles_highlight = getArticlesImg(@articles_highlight)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Admin::Article.find(params[:id])
    end
end