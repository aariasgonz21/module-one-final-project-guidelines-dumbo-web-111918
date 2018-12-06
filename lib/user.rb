require "pry"

class User < ActiveRecord::Base
  has_many :favorites
  has_many :quotes, through: :favorites
  # def favorites
  #   Favorite.all.select {|fave| fave.user_id == self.id }
  # end
  #
  # def quotes
  #   self.favorites.map {|favorite| Quote.find(favorite.quote_id) }
  # end
  def quote_strings
    quotes.map do |quote|
      [quote.quote,  quote.author, quote.category].join("-----")
    end
  end

# returns an array of the users favorite quote content
  def favorite_strings
    self.favorites.map.with_index do |favorite, index|
     #binding.pry
      "#{index+1}" +(". ") + favorite.quote.quote + ("\nArtist: ")  + favorite.quote.author + ("\nCategory: ") + favorite.quote.category + (" \n\n")
      # favorite.quote.quote
    end
 end



end
