require "rails_helper"

RSpec.describe "Repositories", type: :request do
  describe "#index" do
    it "renders the page successfully" do
      get repositories_path

      expect(response).to be_successful
    end

    context "when no results are found" do
    end

    context "when results are found" do
    end
  end
end
