require 'dry/transaction'

module Repositories
  class Search
    include Dry::Transaction
    include GitReader::Deps['github.search']

    step :validate
    step :fetch_repositories

    private

    def validate(query)
      return Failure(:blank_query) if query.blank?

      Success(query)
    end

    def fetch_repositories(query)
      return from_cache(query) if cached?(query)

      search.(query)
    end

    # implement caching
    def cached?(query)
      false
    end

    def from_cache(query)
      Failure(:not_found)
    end
  end
end
