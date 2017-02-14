require "spec_helper"

RSpec.describe OpenBD::Client do
  before do
    @client = OpenBD::Client.new
  end

  describe "#normalize_isbns" do
    it "should normalize ISBN as String" do
      expect(@client.normalize_isbns("9784780801118")).to be == "9784780801118"
    end

    it "should normalize ISBN as Integer" do
      expect(@client.normalize_isbns(9784780801118)).to be == "9784780801118"
    end

    it "should normalize ISBNs as Array of String" do
      expect(@client.normalize_isbns(["9784780801118", "9784939015809"])).to be == "9784780801118,9784939015809"
    end

    it "should normalize ISBNs as Array of Integer" do
      expect(@client.normalize_isbns([9784780801118, 9784939015809])).to be == "9784780801118,9784939015809"
    end
  end
end
