require 'uri'
require 'net/http'

class GoogleBooksApiService

  def initialize(word)
    @word = word
    @base_uri = "https://www.googleapis.com/books/v1/volumes?q="
  end

  def call
  
    uri = URI(@base_uri + @word.word + "&langRestrict=" + @word.lang) # possibility for exception

    res = Net::HTTP.get_response(uri)

    if res.is_a?(Net::HTTPSuccess)
      process_response(res)
    else 
      render json: {status: "error", code: 500, message: "Unsuccessful call to external API."}
    end

  end

  def process_response(res)


    parsed = JSON.parse(res.body)

    parsed['items'].each do |item|
      if item.has_key?("searchInfo")
        if item['searchInfo'].has_key?("textSnippet")
          if item['searchInfo']['textSnippet'].downcase().include?@word.word
            sentence = Sentence.create(sentence: item['searchInfo']['textSnippet'], ranking: 0, word: @word)
            binding.pry
            @word.sentences << sentence
            sentence.save
          end
        end
      end
    end

  end

end
