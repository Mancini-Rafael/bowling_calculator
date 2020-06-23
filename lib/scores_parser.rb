class ScoresParser
  def initialize(scores:[])
    @scores = scores
  end

  def parse
    # Replace invalid scores and fouls for 0
    normalize_score = lambda { |el| el[:score].to_i.negative? ? el.merge!(value: 0) : el.merge!(value: el[:score].to_i) }
    @scores.each(&normalize_score)
    # Split scores by players
    @scores = @scores.group_by{ |el| el[:player] }
    # Check if scores are valid (will raise errors if not)
    check_scores_validity
    # Return structured scores
    @scores
  end

  private

  def check_scores_validity
    @scores.each do |score|
      player, player_scores = score
      current_frame = 0
      number_of_frames = 0
      while current_frame < player_scores.count
        raise "Too many frames in card for player #{player}" if (number_of_frames+1) > 10
        current_score = player_scores[current_frame][:value]
        next_score = player_scores&.[](current_frame+1)&.dig(:value).to_i
        if current_score == 10 # Strike
          current_frame += 1
          number_of_frames += 1
          next
        elsif current_score + next_score <= 10 # Spare/Foul/Miss
          current_frame += 2
          number_of_frames += 1
          next
        end
        raise "Invalid scores in the card for player #{player} on frame #{current_frame+1}" if current_score > 10
        raise "Invalid sum of scores for player #{player} on frame #{current_frame+1}" if current_score + next_score > 10
      end
    end
  end
end