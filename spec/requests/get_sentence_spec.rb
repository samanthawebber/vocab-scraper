require 'rails_helper'

describe "GET /sentences/:id" do
   
  word     = FactoryBot.create(:word, word: 'frightful', lang: 'en')
  sentence = FactoryBot.create(:sentence, sentence: 'The decrepit house had a frightful aspect.', ranking: 2, word: word )

  it "returns http success" do
    get "/sentences/#{sentence.id}"
    expect(response).to have_http_status(:success)
  end
  
  it "returns word for given id" do
    get "/sentences/#{sentence.id}"
    expect(JSON.parse(response.body)['sentence']).to eq(sentence)
  end
end


