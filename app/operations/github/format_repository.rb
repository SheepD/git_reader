module Github
  class FormatRepository
    DEFAULTS = {
      url: nil,
      name: nil,
      owner: nil,
      avatar_url: nil,
      description: nil,
      stars: 0,
      watchers: 0,
      language: nil,
      forks: 0,
      tags: [],
      issues: 0
    }

    def call(repository)
      return DEFAULTS if repository.nil?

      DEFAULTS.merge(
        name: repository.dig(:name),
        owner: repository.dig(:owner, :login),
        avatar_url: repository.dig(:owner, :avatar_url),
        url: repository.dig(:html_url),
        description: repository.dig(:description),
        stars: repository.dig(:stargazers_count),
        watchers: repository.dig(:watchers),
        language: repository.dig(:language),
        forks: repository.dig(:forks),
        tags: repository.dig(:topics),
        issues: repository.dig(:open_issues)
      )
    end
  end
end
