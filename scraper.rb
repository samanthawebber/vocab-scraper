require 'uri'
require 'net/http'
require 'json'


def get_sentences(word, language)

  query_uri = "https://www.googleapis.com/books/v1/volumes?q=" + word + "&langRestrict=" + language

  uri       = URI(query_uri)
  res       = Net::HTTP.get_response(uri)

  if res.is_a?(Net::HTTPSuccess)
    parsed = JSON.parse(res.body)

    parsed['items'].each do |item|
      if item.has_key?("searchInfo")
        if item['searchInfo'].has_key?("textSnippet")
          if item['searchInfo']['textSnippet'].downcase().include? word
            puts item['volumeInfo']['title']
            puts item['volumeInfo']['authors']
            puts item['searchInfo']['textSnippet']
            puts "\n"
          end
        end
      end
    end
  end
end

get_sentences("kutyus", "hu")
