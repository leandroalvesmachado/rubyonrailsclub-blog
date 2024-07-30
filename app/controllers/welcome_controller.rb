# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @articles = Article.all.order(updated_at: :desc).limit(6)
    @categories = Category.all.order(name: :asc).limit(8)
  end
end
