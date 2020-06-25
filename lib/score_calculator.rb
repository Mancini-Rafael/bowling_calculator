# frozen_string_literal: true

class ScoreCalculator
  def initialize(scores: {})
    @scores = scores
  end

  def calculate
    @scores.keys.each do |player|
      frames_info = @scores[player].to_a
      frames_info.each_with_index do |frame_info, index|
        previous_score = index.zero? ? 0 : @scores[player]["frame_#{index}"][:running_total]

        if is_10th_frame?(frame_info)
          # score = Points for this frame
          score = frame_info.last[:scores].sum
        elsif frame_is_strike?(frame_info)
          # score = Points for this frame + Next two rolls (if next roll is also a strike it counts as a single roll)
          additional_score = calculate_additional_score(frames_info, index)
          score = regular_frame_sum(frame_info) + additional_score
        elsif frame_is_spare?(frame_info)
          # score = Points for this frame + First roll of next frame
          score = regular_frame_sum(frame_info) + frames_info[index + 1].last[:scores].first
        else
          # score = Points for this frame
          score = regular_frame_sum(frame_info)
        end
        @scores[player][frame_info.first].merge!(running_total: previous_score + score)
      end
    end
    @scores
  end

  private

  def is_10th_frame?(frame_info)
    frame_info.first == 'frame_10'
  end

  def frame_is_strike?(frame_info)
    frame_info.last[:pinfalls].include?('X')
  end

  def frame_is_spare?(frame_info)
    frame_info.last[:pinfalls].include?('/')
  end

  def regular_frame_sum(frame_info)
    frame_info.last[:scores].first(2).sum
  end

  def calculate_additional_score(frames_info, index)
    if frame_is_strike?(frames_info[index + 1])
      if is_10th_frame?(frames_info[index + 1])
        frames_info[index + 1].last[:scores].first(2).sum
      else
        regular_frame_sum(frames_info[index + 1]) + frames_info[index + 2].last[:scores].first
      end
    else
      regular_frame_sum(frames_info[index + 1])
    end
  end
end
