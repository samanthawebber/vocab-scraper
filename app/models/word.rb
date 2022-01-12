class Word < ApplicationRecord
  has_many :sentences

  validates :word, presence: true, uniqueness: { scope: :lang, case_sensitive: false }
  validates :lang, presence: true
end
