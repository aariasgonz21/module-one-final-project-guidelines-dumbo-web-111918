class Quote < ActiveRecord::Base
  has_many :user, through: :favorites
  has_many :favorites
end
