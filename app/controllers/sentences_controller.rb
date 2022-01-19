require 'json'
include SentenceSorter

class SentencesController < ApplicationController

  def show
    render json: JSONAPI::Serializable::Renderer.new.render(Sentence.find(params[:id]), class: {Sentence: SentenceSerializer}) 
  end


  def generate_sentences

    Word.create(word: params[:word], lang: params[:lang]) # will fail if Word already exists
    word      = Word.find_by(word: params[:word], lang: params[:lang])

    GoogleBooksApiService.new(word).call

    renderer  = JSONAPI::Serializable::Renderer.new
    output    = renderer.render(word.sentences.all, class: {Sentence: SentenceSerializer})
    render json: output
  end


  def update_ranking

    ranking  = params[:ranking]
    sentence = Sentence.find_by(id: params[:id])
    
    sentence.rank(ranking)
    
    render plain: "OK" 
  end

  #add new sentence to list of sentences. If list is full (5 sentences), replace lowest-ranking sentence with this one.
  def new
    
    word = Word.find_by(word: params[:word], lang: params[:lang])
    word.sentences << Sentence.create(sentence: params[:sentence], word: word)
    render plain: "OK"
  end

  params.require(:sentence).permit(:sentence, :ranking, :word)
end
