class Admin::ArticlesController < ApplicationController
  layout "admin"
  before_action :set_admin_article, only: [:show, :edit, :update, :destroy]

  # GET /admin/articles
  # GET /admin/articles.json
  def index
    login
    @admin_articles = Admin::Article.all
    @admin_articles = getArticlesImg(@admin_articles)
    
  end

  # GET /admin/articles/1
  # GET /admin/articles/1.json
  def show
    login
    @admin_article.coverphoto = Admin::Photo.find_by( imageable_id: @admin_article.id,imageable_type: "article_cover")
  end

  # GET /admin/articles/new
  def new
    login
    @admin_article = Admin::Article.new
    @admin_article.coverphoto = Admin::Photo.new(:title => "My photo \##{1 + (Admin::Photo.maximum(:id) || 0)}")
  end

  # GET /admin/articles/1/edit
  def edit
    login
    @admin_article.coverphoto = Admin::Photo.find_by( imageable_id: @admin_article.id,imageable_type: "article_cover")
    if @admin_article.coverphoto.blank?
       @admin_article.coverphoto =  Admin::Photo.new
    end
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @admin_article = Admin::Article.new(admin_article_params)

    respond_to do |format|
      if @admin_article.save
        format.html { redirect_to edit_admin_article_path(@admin_article), notice: 'Article was successfully created. Please add cover photo' }
        format.json { render :show, status: :created, location: @admin_article }
      else
        format.html { render :new }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/articles/1
  # PATCH/PUT /admin/articles/1.json
  def update
    respond_to do |format|
      if @admin_article.update(admin_article_params)
        format.html { redirect_to @admin_article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_article }
      else
        format.html { render :edit }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @admin_article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_article
      @admin_article = Admin::Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_article_params
      params.require(:admin_article).permit(:title,:subtitle, :body, :createdate, :modifydate, :coverphoto_url, :category, :isHighlight, :isToplist)
    end
end
