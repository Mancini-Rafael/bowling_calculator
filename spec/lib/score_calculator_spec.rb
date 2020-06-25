require 'spec_helper'
require_relative "../../lib/score_calculator"

describe ScoreCalculator do
  it "can be instantiated" do
    expect { ScoreCalculator.new }.not_to raise_error
  end

  context "#calculate" do
    it "returns the correct running scores for a regular game" do
      fake_scores = valid_score
      jeff_running_scores = [20, 39, 48, 66, 74, 84, 90, 120, 148, 167]
      john_running_scores = [16, 25, 44, 53, 82, 101, 110, 124, 132, 151]
      calculated_scores = ScoreCalculator.new(scores: fake_scores).calculate
      jeff_calculated_scores = calculated_scores["Jeff"].map(&:last).map{ |el| el[:running_total] }
      john_calculated_scores = calculated_scores["John"].map(&:last).map{ |el| el[:running_total] }
      expect(jeff_running_scores).to eq(jeff_calculated_scores)
      expect(john_running_scores).to eq(john_calculated_scores)
    end
    it "returns the correct running scores for a all-fouls game" do
      fake_scores = all_fouls_score
      jeff_running_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      john_running_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      calculated_scores = ScoreCalculator.new(scores: fake_scores).calculate
      jeff_calculated_scores = calculated_scores["Jeff"].map(&:last).map{ |el| el[:running_total] }
      john_calculated_scores = calculated_scores["John"].map(&:last).map{ |el| el[:running_total] }
      expect(jeff_running_scores).to eq(jeff_calculated_scores)
      expect(john_running_scores).to eq(john_calculated_scores)
    end
    it "returns the correct running scores for a all-strikes game" do
      fake_scores = all_strikes_score
      jeff_running_scores = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      john_running_scores = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      calculated_scores = ScoreCalculator.new(scores: fake_scores).calculate
      jeff_calculated_scores = calculated_scores["Jeff"].map(&:last).map{ |el| el[:running_total] }
      john_calculated_scores = calculated_scores["John"].map(&:last).map{ |el| el[:running_total] }
      expect(jeff_running_scores).to eq(jeff_calculated_scores)
      expect(john_running_scores).to eq(john_calculated_scores)
    end
  end

  def valid_score
    { "Jeff" =>
      { "frame_1" => {:pinfalls=>["", "X"], :scores=>[10, 0] },
        "frame_2"=>{:pinfalls=>["7", "/"], :scores=>[7, 3]},
        "frame_3"=>{:pinfalls=>["9", "0"], :scores=>[9, 0]},
        "frame_4"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_5"=>{:pinfalls=>["0", "8"], :scores=>[0, 8]},
        "frame_6"=>{:pinfalls=>["8", "/"], :scores=>[8, 2]},
        "frame_7"=>{:pinfalls=>["F", "6"], :scores=>[0, 6]},
        "frame_8"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_9"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_10"=>{:pinfalls=>["X", "8", "1"], :scores=>[10, 8, 1]}
      },
      "John"=> 
      { "frame_1"=>{:pinfalls=>["3", "/"], :scores=>[3, 7]}, # 16
        "frame_2"=>{:pinfalls=>["6", "3"], :scores=>[6, 3]}, # 25
        "frame_3"=>{:pinfalls=>["", "X"], :scores=>[10, 0]}, # 44
        "frame_4"=>{:pinfalls=>["8", "1"], :scores=>[8, 1]}, # 53
        "frame_5"=>{:pinfalls=>["", "X"], :scores=>[10, 0]}, # 82
        "frame_6"=>{:pinfalls=>["", "X"], :scores=>[10, 0]}, # 101
        "frame_7"=>{:pinfalls=>["9", "0"], :scores=>[9, 0]}, # 110
        "frame_8"=>{:pinfalls=>["7", "/"], :scores=>[7, 3]}, # 124
        "frame_9"=>{:pinfalls=>["4", "4"], :scores=>[4, 4]}, # 132
        "frame_10"=>{:pinfalls=>["X", "9", "0"], :scores=>[10, 9, 0]}} #151
    }
  end

  def all_fouls_score
    { "Jeff" =>
      { "frame_1" => {:pinfalls=>["F", "F"], :scores=>[0, 0] },
        "frame_2"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_3"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_4"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_5"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_6"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_7"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_8"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_9"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_10"=>{:pinfalls=>["F", "F", "F"], :scores=>[0, 0, 0]}
      },
      "John"=> 
      { "frame_1" => {:pinfalls=>["F", "F"], :scores=>[0, 0] },
        "frame_2"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_3"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_4"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_5"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_6"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_7"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_8"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_9"=>{:pinfalls=>["F", "F"], :scores=>[0, 0]},
        "frame_10"=>{:pinfalls=>["F", "F", "F"], :scores=>[0, 0, 0]}
      }
    }
  end

  def all_strikes_score
    { "Jeff" =>
      { "frame_1" => {:pinfalls=>["", "X"], :scores=>[10, 0] },
        "frame_2"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_3"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_4"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_5"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_6"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_7"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_8"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_9"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_10"=>{:pinfalls=>["X", "X", "X"], :scores=>[10, 10, 10]}
      },
      "John"=> 
      { "frame_1" => {:pinfalls=>["", "X"], :scores=>[10, 0] },
        "frame_2"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_3"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_4"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_5"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_6"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_7"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_8"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_9"=>{:pinfalls=>["", "X"], :scores=>[10, 0]},
        "frame_10"=>{:pinfalls=>["X", "X", "X"], :scores=>[10, 10, 10]}
      }
    }
  end
end
