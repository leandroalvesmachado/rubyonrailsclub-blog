# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    before_action :set_category, only: [:show, :edit, :update, :destroy, :destroy_cover_image]

    def index
      @categories = Category.all
    end

    def show
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)
      @category.cover_image.attach(category_params[:cover_image])

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

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html do
            redirect_to(administrate_categories_url(@category), notice: "Category was successfully updated.")
          end
          format.json { render(:show, status: :ok, location: @category) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    def destroy
      respond_to do |format|
        format.html do
          if @category.articles.count > 0
            redirect_to(
              administrate_categories_url,
              alert: "Existem Artigos associados a essa categoria. Não é possível apagá-la.",
            )
          else
            @category.destroy!
            redirect_to(administrate_categories_url, notice: "Categoria apagada com sucesso!")
          end
        end
        format.json { head(:no_content) }
      end
    end

    # DELETE /administrate/categories/:id/destroy_cover_image
    def destroy_cover_image
      @category.cover_image.purge

      respond_to do |format|
        format.turbo_stream { render(turbo_stream: turbo_stream.remove(@category)) }
      end
    end

    private

    def category_params
      params.require(:category).permit(:name, :description, :cover_image)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
