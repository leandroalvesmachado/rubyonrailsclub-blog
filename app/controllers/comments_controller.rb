# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_article, only: [:create]

  def create
    @article.comments.create!(comment_params)

    redirect_to(article_path(@article))
  end

  private

  def set_article
    @article = Article.friendly.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
