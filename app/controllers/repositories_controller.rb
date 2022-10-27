class RepositoriesController < ApplicationController
  def index
    @query = params[:query]

    resolve("repositories.search").(@query) do |m|
      m.success do |result|
        @repos = result
      end

      m.failure do |error|
        @error = error
      end
    end
  end
end
