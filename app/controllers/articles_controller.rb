class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    
    if has_cat?
      if params[:cat] == '1'
       @articles = Admin::Article.where( :category => 'Article')
      elsif params[:cat] == '2'
        @articles = Admin::Article.where(:category => 'HowTo')
      elsif params[:cat] == '3'
        @articles = Admin::Article.where( :category => 'Activities')
      end
    else
      @articles =Admin::Article.all
    end
     @articles = getArticlesImg(@articles)
  end
  def show
    
    @article.coverphoto = Admin::Photo.find_by( imageable_id: @article.id,imageable_type: "article_cover")
  	@articles_highlight = Admin::Article.where( :category => @article.category) 
    @articles_highlight = @articles_highlight.where.not(:id => @article.id).order(updated_at: :desc).limit(3)
    @articles_highlight = getArticlesImg(@articles_highlight)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Admin::Article.find(params[:id])
    end
    def has_cat?
      params[:cat].present?
    end
end