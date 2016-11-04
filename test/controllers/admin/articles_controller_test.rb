require 'test_helper'

class Admin::ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_article = admin_articles(:one)
  end

  test "should get index" do
    get admin_articles_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_article_url
    assert_response :success
  end

  test "should create admin_article" do
    assert_difference('Admin::Article.count') do
      post admin_articles_url, params: { admin_article: { body: @admin_article.body, category: @admin_article.category, coverphoto_url: @admin_article.coverphoto_url, createdate: @admin_article.createdate, isHighlight: @admin_article.isHighlight, isToplist: @admin_article.isToplist, modifydate: @admin_article.modifydate, topic: @admin_article.topic } }
    end

    assert_redirected_to admin_article_url(Admin::Article.last)
  end

  test "should show admin_article" do
    get admin_article_url(@admin_article)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_article_url(@admin_article)
    assert_response :success
  end

  test "should update admin_article" do
    patch admin_article_url(@admin_article), params: { admin_article: { body: @admin_article.body, category: @admin_article.category, coverphoto_url: @admin_article.coverphoto_url, createdate: @admin_article.createdate, isHighlight: @admin_article.isHighlight, isToplist: @admin_article.isToplist, modifydate: @admin_article.modifydate, topic: @admin_article.topic } }
    assert_redirected_to admin_article_url(@admin_article)
  end

  test "should destroy admin_article" do
    assert_difference('Admin::Article.count', -1) do
      delete admin_article_url(@admin_article)
    end

    assert_redirected_to admin_articles_url
  end
end
