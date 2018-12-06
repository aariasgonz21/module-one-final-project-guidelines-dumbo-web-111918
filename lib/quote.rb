class Quote < ActiveRecord::Base
  has_many :favorites
  has_many :users, through: :favorites

  def to_tty_hash
    {self.quote =>self.id}
  end

  def self.motivational_category
    self.all.where(category: "motivational")
    # self.all.select do |quote|
    #   quote.category == "motivational"
    #   #binding.pry
    # end
  end

  def self.funny_category
    self.all.select do |quote|
      quote.category == "funny"
    end
  end

  def self.friendship_category
    self.all.select do |quote|
      quote.category == "friendship"
    end
  end

  def self.depressing_category
    self.all.select do |quote|
      quote.category == "depressing"
      #binding.pry
    end
  end

  def self.love_category
    self.all.select do |quote|
      quote.category == "love"
      #binding.pry
    end
  end

  def self.categories
    self.all.map do |quote|
        quote.category
     end.uniq
   end
end
