class Sentence < ApplicationRecord
  belongs_to :word
  validates :sentence, uniqueness: true
end
