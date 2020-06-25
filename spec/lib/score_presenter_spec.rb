require 'spec_helper'
require_relative "../../lib/score_presenter"

describe ScorePresenter do
  it "can be instantiated" do
    expect { ScorePresenter.new }.not_to raise_error
  end

  context "#present" do
    it "prints the scores for a regular game using the correct format" do
      fake_scores = valid_score
      expect do
        ScorePresenter.new(content: fake_scores).present
      end.to output(valid_score_output).to_stdout
    end
    it "prints the scores for a all-fouls game using the correct format" do
      fake_scores = all_fouls_score
      expect do
        ScorePresenter.new(content: fake_scores).present
      end.to output(all_fouls_output).to_stdout
    end
    it "prints the scores for a all-strikes game using the correct format" do
      fake_scores = all_strikes_score
      expect do
        ScorePresenter.new(content: fake_scores).present
      end.to output(all_strikes_output).to_stdout
    end
  end

  def valid_score
    { "Jeff" =>
      { "frame_1" => {:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>20},
        "frame_2" => {:pinfalls=>["7", "/"], :scores=>[7, 3], :running_total=>39},
        "frame_3" => {:pinfalls=>["9", "0"], :scores=>[9, 0], :running_total=>48},
        "frame_4" => {:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>66},
        "frame_5" => {:pinfalls=>["0", "8"], :scores=>[0, 8], :running_total=>74},
        "frame_6" => {:pinfalls=>["8", "/"], :scores=>[8, 2], :running_total=>84},
        "frame_7" => {:pinfalls=>["F", "6"], :scores=>[0, 6], :running_total=>90},
        "frame_8" => {:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>120},
        "frame_9" => {:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>148},
        "frame_10" => {:pinfalls=>["X", "8", "1"], :scores=>[10, 8, 1], :running_total=>167}
      },
      "John" =>
      { "frame_1"=>{:pinfalls=>["3", "/"], :scores=>[3, 7], :running_total=>16},
        "frame_2"=>{:pinfalls=>["6", "3"], :scores=>[6, 3], :running_total=>25},
        "frame_3"=>{:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>44},
        "frame_4"=>{:pinfalls=>["8", "1"], :scores=>[8, 1], :running_total=>53},
        "frame_5"=>{:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>82},
        "frame_6"=>{:pinfalls=>["", "X"], :scores=>[10, 0], :running_total=>101},
        "frame_7"=>{:pinfalls=>["9", "0"], :scores=>[9, 0], :running_total=>110},
        "frame_8"=>{:pinfalls=>["7", "/"], :scores=>[7, 3], :running_total=>124},
        "frame_9"=>{:pinfalls=>["4", "4"], :scores=>[4, 4], :running_total=>132},
        "frame_10"=>{:pinfalls=>["X", "9", "0"], :scores=>[10, 9, 0], :running_total=>151}
      }
    }
  end
  def valid_score_output
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nJeff\nPinfalls\t\tX\t7\t/\t9\t0\t\tX\t0\t8\t8\t/\tF\t6\t\tX\t\tX\tX\t8\t1\nScore\t\t20\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\nJohn\nPinfalls\t3\t/\t6\t3\t\tX\t8\t1\t\tX\t\tX\t9\t0\t7\t/\t4\t4\tX\t9\t0\nScore\t\t16\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\n"
  end

  def all_fouls_score
    { "Jeff" =>
      { "frame_1" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_2" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_3" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_4" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_5" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_6" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_7" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_8" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_9" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_10" => {:pinfalls=>["F", "F", "F"], :scores=>[0, 0, 0], :running_total=>0}
      },
      "John" =>
      { "frame_1" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_2" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_3" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_4" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_5" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_6" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_7" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_8" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_9" => {:pinfalls=>["F", "F"], :scores=>[0, 0], :running_total=>0},
        "frame_10" => {:pinfalls=>["F", "F", "F"], :scores=>[0, 0, 0], :running_total=>0}
      }
    }
  end
  def all_fouls_output
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nJeff\nPinfalls\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\nScore\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\nJohn\nPinfalls\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\nScore\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\n"
  end

  def all_strikes_score
    { "Jeff" =>
      { "frame_1" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>30},
        "frame_2" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>60},
        "frame_3" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>90},
        "frame_4" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>120},
        "frame_5" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>150},
        "frame_6" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>180},
        "frame_7" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>210},
        "frame_8" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>240},
        "frame_9" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>270},
        "frame_10" => {:pinfalls=>["X", "X", "X"], :scores=>[10, 10, 10], :running_total=>300}
      },
      "John"=> 
      { "frame_1" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>30},
        "frame_2" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>60},
        "frame_3" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>90},
        "frame_4" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>120},
        "frame_5" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>150},
        "frame_6" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>180},
        "frame_7" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>210},
        "frame_8" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>240},
        "frame_9" => {:pinfalls=>["", "X"], :scores=>[10, 10], :running_total=>270},
        "frame_10" => {:pinfalls=>["X", "X", "X"], :scores=>[10, 10, 10], :running_total=>300}
      }
    }
  end
  def all_strikes_output
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nJeff\nPinfalls\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\nScore\t\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\nJohn\nPinfalls\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\nScore\t\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\n"
  end
end
