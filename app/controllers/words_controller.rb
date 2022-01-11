require 'uri'
require 'net/http'
require 'json'

class WordsController < ApplicationController

  def get_sentences
    
    word      = params[:word]
    lang      = params[:lang]
    sentences = ''

    query_uri = "https://www.googleapis.com/books/v1/volumes?q=" + word + "&langRestrict=" + lang

    uri       = URI(query_uri)
    res       = Net::HTTP.get_response(uri)

    if res.is_a?(Net::HTTPSuccess)
     parsed   = JSON.parse(res.body)
     parsed['items'].each do |item|

      if item.has_key?("searchInfo")
        if item['searchInfo'].has_key?("textSnippet")
         if item['searchInfo']['textSnippet'].downcase().include? word
           sentences += item['searchInfo']['textSnippet'] + "\n"
         end
        end
      end
    end
   end

    render json: sentences

  end

end
