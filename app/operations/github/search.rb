require 'dry/transaction'

module Github
  class Search
    include Dry::Transaction
    include GitReader::Deps['github.format_repository']

    step :fetch_repositories
    step :format_repositories
    step :cache_results

    private

    def fetch_repositories(query)
      # register dependency
      result = Octokit::Client.new.search_repositories(query)
      Success(repos: result[:items], query: query)
    end

    def format_repositories(repos:, query:)
      return Success(repos: [], query: query) if repos.blank?

      result = repos.map { |repo| format_repository.(repo) }
      Success(repos: result, query: query)
    end

    # TODO: implement caching
    def cache_results(repos:, query:)
      return Success([]) if repos.blank?

      Success(repos)
    end
  end
end
