require 'spec_helper'
require_relative "../../lib/scores_parser"

describe ScoresParser do
  it "can be instantiated" do
    expect { ScoresParser.new }.not_to raise_error
  end

  context "#parse" do
    context "when handling invalid data" do
      it "raises errors for scores too large" do
        fake_scores = [ { player: "Jeff", score: "12" } ]
        parser = ScoresParser.new(scores: fake_scores)
        expect { parser.parse }.to raise_error(RuntimeError, "Invalid scores in the card for player Jeff on frame 1")
      end
      it "raises errors for score sums too large" do
        fake_scores = [
          { player: "Jeff", score: "8" },
          { player: "Jeff", score: "8" }
        ]
        parser = ScoresParser.new(scores: fake_scores)
        expect { parser.parse }.to raise_error(RuntimeError, "Invalid sum of scores for player Jeff on frame 1")
      end
      it "raises errors for too many frames" do
        fake_scores = Array.new(30, { player: "Jeff", score: "X" })
        parser = ScoresParser.new(scores: fake_scores)
        expect { parser.parse }.to raise_error(RuntimeError, "Too many frames for Jeff")
      end
    end
    context "when handling valid data" do
      it "returns structured score information" do
        fake_scores = [
          { player: "Jeff", score: "10" },
          { player: "John", score: "8" },
          { player: "John", score: "2" },

          { player: "Jeff", score: "6" },
          { player: "Jeff", score: "3" },
          { player: "John", score: "10" },

          { player: "Jeff", score: "10" },
          { player: "John", score: "10" },

          { player: "Jeff", score: "F" },
          { player: "Jeff", score: "F" },
          { player: "John", score: "F" },
          { player: "John", score: "F" }
        ]
        scores = ScoresParser.new(scores: fake_scores).parse
        expect(scores).to be_instance_of(Hash)
        expect(scores).not_to be_empty
        expect(scores["Jeff"]).not_to be_empty
        expect(scores["John"]).not_to be_empty
        expect(scores["Jeff"].length).to eq(4)
        expect(scores["John"].length).to eq(4)
      end
    end
  end
end
