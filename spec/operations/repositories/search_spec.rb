require "rails_helper"

RSpec.describe Repositories::Search do
  describe "#call" do
    subject { described_class.new(search: search) }

    context "when query is present and result is uncached" do
      let(:query) { "octocat" }
      let(:search) { double("search", call: Dry::Monads::Success([1, 2])) }

      it "returns a list of repositories" do
        result = subject.call(query)

        expect(result).to be_success
        expect(result.success).to eq([1, 2])
      end
    end

    context "when query is blank" do
      let(:query) { "" }
      let(:search) { double("search", call: Dry::Monads::Success([1])) }

      it "fails with a blank_query" do
        result = subject.call(query)

        expect(result).to be_failure
        expect(result.failure).to eq(:blank_query)
      end
    end

    context "when query is cached" do
      let(:query) { "cached" }

      xit "returns the cached result"
    end
  end
end
