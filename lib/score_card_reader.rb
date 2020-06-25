# frozen_string_literal: true

class ScoreCardReader
  def initialize(file_path: nil)
    @file_path = file_path
  end

  def read
    raise 'File is not valid' unless file_is_valid?

    begin
      # foreach is important to keep scalability
      data = []
      File.foreach(@file_path) do |line|
        player, score = line.split(' ')
        data << { player: player, score: score }
      end
      data
    rescue StandardError
      raise 'Error reading file'
    end
  end

  private

  def file_is_valid?
    return false if !File.file?(@file_path) || File.zero?(@file_path)

    true
  end
end
