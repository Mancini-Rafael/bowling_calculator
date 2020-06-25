# frozen_string_literal: true

class ScorePresenter
  def initialize(content: {})
    @content = content
  end

  def present
    print_header
    players = @content.keys
    players.each do |player_name|
      print_name(player_name)
      print_pinfalls(player_name)
      print_score(player_name)
    end
  end

  private

  def print_header
    elems = ['Frame'] + (1..10).to_a
    header = elems.join("\t\t")
    puts(header)
  end

  def print_name(name)
    puts(name)
  end

  def print_pinfalls(player)
    elems = ['Pinfalls'] + @content[player].to_a.map(&:last).map { |el| el[:pinfalls] }
    pinfalls = elems.join("\t")
    puts(pinfalls)
  end

  def print_score(player)
    elems = ['Score'] + @content[player].to_a.map(&:last).map { |el| el[:running_total] }
    running_scores = elems.join("\t\t")
    puts(running_scores)
  end
end
