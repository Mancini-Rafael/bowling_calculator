class ScoresParser
  def initialize(scores:[])
    @scores = scores
  end

  def parse
    @formatted_scores = {}
    # Replace invalid scores and fouls for 0
    evaluate_score = lambda { |el| el[:score].to_i.negative? ? el.merge!(value: 0) : el.merge!(value: el[:score].to_i) }
    @scores.each(&evaluate_score)
    # Split scores by players
    @scores = @scores.group_by{ |el| el[:player] }
    # Populate structured scores (will raise errors if scores are invalid)
    parse_scores
    # Return structured scores
    @formatted_scores
  end

  private

  def populate_structured_scores(fn:, pins:, scores:)
    @formatted_scores[@player]["frame_#{fn}"] = 
      { pinfalls: pins, scores: scores }
  end

  def parse_scores
    @scores.each do |score|
      # Create structured score for player
      @player, player_scores = score
      @formatted_scores[@player] = {}

      # Run through player scores populating information
      current_frame = 0
      number_of_frames = 0
      while current_frame < player_scores.count
        current_score_value = player_scores[current_frame][:value]
        current_score = player_scores[current_frame][:score]
        next_score_value = player_scores&.[](current_frame+1)&.dig(:value).to_i
        next_score = player_scores&.[](current_frame+1)&.dig(:score)
        if number_of_frames < 9
          if current_score_value == 10 # Strike
            current_frame += 1
            number_of_frames += 1
            populate_structured_scores(fn: number_of_frames, pins: ["", "X"], scores: [current_score_value, 0])
            next
          elsif current_score_value + next_score_value == 10 # Spare
            current_frame += 2
            number_of_frames += 1
            populate_structured_scores(fn: number_of_frames, pins: [current_score, "/"], scores: [current_score_value, next_score_value])
            next
          elsif current_score_value + next_score_value < 10 # Foul/Miss
            current_frame += 2
            number_of_frames += 1
            populate_structured_scores(fn: number_of_frames, pins: [current_score, next_score], scores: [current_score_value, next_score_value])
            next
          end
        else # 10th frame
          current_score = current_score_value == 10 ? "X" : current_score
          next_score = next_score_value == 10 ? "X" : next_score
          extra_score_value = player_scores&.[](current_frame+2)&.dig(:value).to_i
          extra_score = player_scores&.[](current_frame+2)&.dig(:score)
          extra_score = extra_score_value == 10 ? "X" : extra_score
          current_frame += 3
          number_of_frames += 1
          populate_structured_scores(fn: number_of_frames,
                                     pins: [current_score, next_score, extra_score],
                                     scores: [current_score_value, next_score_value, extra_score_value])
          next
        end
        raise "Invalid scores in the card for player #{@player} on frame #{current_frame+1}" if current_score_value > 10
        raise "Invalid sum of scores for player #{@player} on frame #{current_frame+1}" if current_score_value + next_score_value > 10
      end
    end
  end
end