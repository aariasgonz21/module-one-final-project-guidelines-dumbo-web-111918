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
end
