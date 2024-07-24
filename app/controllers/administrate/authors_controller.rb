# frozen_string_literal: true

module Administrate
  class AuthorsController < AdministrateController
    before_action :set_author, only: [:show, :edit, :update, :destroy, :destroy_avatar_image]

    def index
      @authors = Author.all
    end

    def show
    end

    def new
      @author = Author.new
    end

    def edit
    end

    def create
      @author = Author.new(author_params)
      @author.avatar_image.attach(author_params[:avatar_image])

      respond_to do |format|
        if @author.save
          format.html do
            redirect_to(administrate_authors_url(@author), notice: "Author was successfully created.")
          end
          format.json { render(:show, status: :created, location: @author) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @author.errors, status: :unprocessable_entity) }
        end
      end
    end

    def update
      respond_to do |format|
        if @author.update(author_params)
          format.html do
            redirect_to(administrate_authors_url(@author), notice: "Author was successfully updated.")
          end
          format.json { render(:show, status: :ok, location: @author) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @author.errors, status: :unprocessable_entity) }
        end
      end
    end

    def destroy
      respond_to do |format|
        format.html do
          if @author.articles.count > 0
            redirect_to(
              administrate_authors_url,
              alert: "Existem Artigos associados a esse autor. Não é possível apagá-la.",
            )
          else
            @author.destroy!
            redirect_to(administrate_authors_url, notice: "Autor apagado com sucesso!")
          end
        end
        format.json { head(:no_content) }
      end
    end

    # DELETE /administrate/authors/:id/destroy_avatar_image
    def destroy_avatar_image
      @author.avatar_image.purge

      respond_to do |format|
        format.turbo_stream { render(turbo_stream: turbo_stream.remove(@author)) }
      end
    end

    private

    def author_params
      params.require(:author).permit(
        :name,
        :description,
        :facebook_profile_url,
        :instagram_profile_url,
        :twitter_profile_url,
        :linkedin_profile_url,
        :youtube_profile_url,
        :avatar_image,
      )
    end

    def set_author
      @author = Author.find(params[:id])
    end
  end
end
