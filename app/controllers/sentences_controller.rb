require 'uri'
require 'net/http'
require 'json'

class SentencesController < ApplicationController

  def get_sentences

    # create Word, or if already exists, then assign that instance to word var 
    
    Word.create(word: params[:word], lang: params[:lang])

    word      = Word.find_by(word: params[:word], lang: params[:lang])

    query_uri = "https://www.googleapis.com/books/v1/volumes?q=" + word.word + "&langRestrict=" + word.lang

    uri       = URI(query_uri)
    res       = Net::HTTP.get_response(uri)

    if res.is_a?(Net::HTTPSuccess)
     parsed   = JSON.parse(res.body)
     parsed['items'].each do |item|

      if item.has_key?("searchInfo")
        if item['searchInfo'].has_key?("textSnippet")
          if item['searchInfo']['textSnippet'].downcase().include? word.word
           
           sentence = Sentence.create(sentence: item['searchInfo']['textSnippet'], ranking: 0, word: word) 
           #sentences += item['searchInfo']['textSnippet'] + "\n"
           word.sentences << sentence
         end
        end
      end
    end
   end

    renderer = JSONAPI::Serializable::Renderer.new
    output = renderer.render(word.sentences.all, class: {Sentence: SentenceSerializer})
    render json: output
  end

  # increment or decrement rating of sentence by one. If ranking falls below some limit, remove sentence from list.
  def update_ranking

    ranking  = params[:ranking]
    sentence = Sentence.find_by(id: params[:id])

    if(ranking == "positive")
      sentence.ranking+=1
    elsif(ranking == "negative")
      sentence.ranking-=1
    else
      render plain: "Invalid input: " + params[:ranking]
      return
    end
    sentence.save
    
    render plain: "OK" 
  end

  #add new sentence to list of sentences. If list is full (5 sentences), replace lowest-ranking sentence with this one.
  def put_sentence
    
    word = Word.find_by(word: params[:word], lang: params[:lang])
    word.sentences << Sentence.create(sentence: params[:sentence], word: word)
    render plain: "OK"
  end

end
