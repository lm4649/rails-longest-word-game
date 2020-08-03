require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z].sample(10)
  end

  def score
    # binding.pry
    letters = params[:tags_list].gsub(",", "").split('')
    @result = { score: 0, message: "Sorry but #{params[:word]} can't be built out of #{params[:tags_list]}" }
    if not_overused?(params[:word], letters)
      file = read_json(params[:word])
      if file["found"]
        @result[:score] = params[:word].size
        @result[:message] = "Congratulations! #{params[:word]} is a valid English word!"
      else
        @result[:message] = "Sorry but #{params[:word]} does not seem to be a valid English word..."
      end
    end
  end

  private

  def not_overused?(word, grid)
    word_array = word.upcase.chars
    word_array.all? { |char| word_array.count(char) <= grid.count(char) }
  end

  def read_json(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt.downcase}"
    file_serialized = open(url).read
    JSON.parse(file_serialized)
  end
end
