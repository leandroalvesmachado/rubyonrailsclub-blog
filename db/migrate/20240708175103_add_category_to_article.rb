# frozen_string_literal: true

class AddCategoryToArticle < ActiveRecord::Migration[7.1]
  def change
    add_reference(:articles, :category, null: true, foreign_key: true, type: :uuid)
  end
end
