class Word < ApplicationRecord
  include SentenceSorter

  MAX_SENTENCE_LIMIT = 5

  has_many :sentences, before_add: :validate_user_limit, :dependent => :destroy

  validates :word, presence: true, uniqueness: { scope: :lang, case_sensitive: false }
  validates :lang, presence: true

  private

  def validate_user_limit(sentence)
    raise Exception.new if sentences.count >= MAX_SENTENCE_LIMIT
  end
end
