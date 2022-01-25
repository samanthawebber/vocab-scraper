require 'rails_helper'

RSpec.describe Word, :type => :model do
  word = FactoryBot.build(:word)
  
  it "is valid with valid attributes" do
    expect(word).to be_valid
  end


  it "is not valid without a language" do
    word.lang = nil
    expect(word).to_not be_valid
  end 


  it "is not valid with more than 5 sentences"
    for i in 0..5 do
      word.sentences << FactoryBot.build(:sentence)  
      expect(word).to_not be_valid
    end
end
