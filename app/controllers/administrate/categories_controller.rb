# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    def index
      @categories = Category.all
    end
  end
end
