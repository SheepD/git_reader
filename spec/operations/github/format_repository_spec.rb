require "rails_helper"

RSpec.describe Github::FormatRepository do
  describe "#call" do
    subject { described_class.new }

    context "when the input is nil" do
      let(:repo) { nil }

      it "returns the defaults" do
        output = Github::FormatRepository::DEFAULTS

        expect(subject.call(repo)).to eq(output)
      end
    end

    context "when the input is correct" do
      let(:repo) do
        {
          name: "test",
          owner: {
              login: "user",
              avatar_url: "https://avatars.githubusercontent.com/u/123456?v=4",
              url: "https://api.github.com/users/user"
            },
          html_url: "https://github.com/user/test",
          description: "test",
          stargazers_count: 214,
          watchers_count: 214,
          language: "Ruby",
          open_issues_count: 17,
          topics: ["hacktoberfest"],
          forks: 50,
          open_issues: 17,
          watchers: 214
        }
      end

      it "returns a formatted repository" do
        output = {
          url: "https://github.com/user/test",
          name: "test",
          owner: "user",
          avatar_url: "https://avatars.githubusercontent.com/u/123456?v=4",
          description: "test",
          stars: 214,
          watchers: 214,
          language: "Ruby",
          forks: 50,
          tags: ["hacktoberfest"],
          issues: 17
        }

        expect(subject.call(repo)).to eq(output)
      end
    end
  end
end
