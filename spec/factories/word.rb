require 'faker'

FactoryBot.define do
  factory :word do 
    word { Faker::Lorem.words(number: 1) }
    lang { Word::ISO_639_CODES.sample }
  end
end
