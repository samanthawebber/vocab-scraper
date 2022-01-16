class Sentence < ApplicationRecord
  include SentenceSorter

  belongs_to :word
  validates :sentence, uniqueness: true

  # updates sentence.rating according to rating given in parameters. If ranking is too low, remove sentence from word.
  def rank(ranking)

    if(ranking == "positive")
      self.ranking+=1
    elsif(ranking == "negative")
      self.ranking-=1
    else
      render plain: "Invalid input: " + ranking + ". Ranking must be string literal positive or string literal negative."
      return
    end

    save

    remove_if_low_ranking_sentence(self) 
  end

end
