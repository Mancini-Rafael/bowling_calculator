require 'spec_helper'
require_relative "../../lib/score_card_reader"

describe ScoreCardReader do
  it "can be instantiated" do
    expect { ScoreCardReader.new }.not_to raise_error
  end

  context "#read" do
    context "when handling improper files" do
      it "raises errors for invalid files" do
        file_path = "#{RSPEC_ROOT}/examples/empty.txt"
        reader = ScoreCardReader.new(file_path: file_path)
        expect { reader.read }.to raise_error(RuntimeError, "File is not valid")
      end
  
      it "raises errors for non-existent files" do
        file_path = "#{RSPEC_ROOT}/examples/non-existant.txt"
        reader = ScoreCardReader.new(file_path: file_path)
        expect { reader.read }.to raise_error(RuntimeError, "File is not valid")
      end
    end
    context "when handling valid files" do
      it "does not raise error reading valid file" do
        file_path = "#{RSPEC_ROOT}/examples/valid.txt"
        reader = ScoreCardReader.new(file_path: file_path)
        expect { reader.read }.not_to raise_error
      end

      it "returns structured file information" do
        file_path = "#{RSPEC_ROOT}/examples/valid.txt"
        reader = ScoreCardReader.new(file_path: file_path)
        result = reader.read
        expect(result).to be_instance_of(Array)
        expect(result).not_to be_empty
        expect(result.first.keys).to match_array([:player, :score])
      end
    end
  end
end
