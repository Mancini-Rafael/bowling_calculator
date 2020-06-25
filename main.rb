# frozen_string_literal: true

require './lib/scores_parser'
require './lib/score_card_reader'
require './lib/score_calculator'
require './lib/score_presenter'

def run(file_path:)
  puts('Welcome to the bowling score parser and calculator')
  if file_path.nil? || file_path == ''
    puts('ERROR => Please enter a file path for analysis')
    exit 1
  else
    puts("Analyzing file in path #{file_path}")
    content = ScoreCardReader.new(file_path: file_path).read
    validated_scores = ScoresParser.new(scores: content).parse
    calculated_scores = ScoreCalculator.new(scores: validated_scores).calculate
    ScorePresenter.new(content: calculated_scores).present
  end
end

run(file_path: ARGV[0])
