require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    @letters
  end

  def score
    @score = params[:word]
    if english_word?(@score) && word_count(@score) && present(@score) == true
      @word = 'OOOH YEAH FNALLY, I earn 100pts'
    else
      @word = 'shit'
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def word_count(word)
    true if word.length <= 10
  end

  def present(word)
    letters = params[:letters]
    letters.chars.each & :gsub == word
  end
end
