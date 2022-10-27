require "rails_helper"

RSpec.describe Github::Search do
  describe "#call" do
    subject { described_class.new(format_repository: format_repository) }
    let(:format_repository) { double("format_repository", call: {}) }

    context "when the result is empty" do
      let(:query) { "ctokite" }

      it "returns an empty array" do
        VCR.use_cassette("github/search_repositories/blank") do
          expect(format_repository).not_to receive(:call).with(any_args)
          result = subject.call(query)

          expect(result).to be_success
          expect(result.success).to eq([])
        end
      end
    end

    context "when the result is not empty" do
      let(:query) { "octokit" }

      it "returns a formatted list of repositories" do
        VCR.use_cassette("github/search_repositories/success") do
          expect(format_repository).to receive(:call).with(any_args).exactly(30).times
          result = subject.call(query)

          expect(result).to be_success
          expect(result.success.size).to eq(30)
        end
      end
    end
  end
end
