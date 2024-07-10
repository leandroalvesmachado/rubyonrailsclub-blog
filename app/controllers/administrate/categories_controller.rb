# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html do
            redirect_to(administrate_categories_url(@category), notice: "Category was successfully created.")
          end
          format.json { render(:show, status: :created, location: @category) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.friendly.find(params[:id])
    end
  end
end
