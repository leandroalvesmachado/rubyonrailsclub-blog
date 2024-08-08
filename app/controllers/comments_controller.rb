# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_article, only: [:index]

  def index
    @comments = @article.comments
  end

  private

  def set_article
    @article = Article.friendly.find(params[:article_id])
  end
end
