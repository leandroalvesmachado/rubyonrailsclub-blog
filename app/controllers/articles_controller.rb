# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def show
    @other_articles = Article.all.sample(3)
    @comments = comments_sorted_by
  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def comments_sorted_by
    return @article.comments.order(created_at: :desc) if params[:sort_by] == "more_recents"

    @article.comments.order(created_at: :asc)
  end
end
