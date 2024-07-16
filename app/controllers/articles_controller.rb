# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    # @article = Article.find(params[:id])
    @article = Article.friendly.find(params[:id])
  end
end
