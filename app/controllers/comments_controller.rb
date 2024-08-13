# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:create]

  def create
    comment = @article.comments.new(comment_params)

    if comment.save
      redirect_to(article_path(@article), notice: "Comentário criado com sucesso")
    else
      redirect_to(
        article_path(@article),
        alert: "Erro ao criar comentário! - #{comment.errors.full_messages.join(",")}",
      )
    end
  end

  private

  def set_article
    @article = Article.friendly.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
