require 'json'
include SentenceSorter

class SentencesController < ApplicationController

  def show

    sentence = Sentence.find(params[:id])
    render json: rendered_sentence(sentence)    
  end


  def generate_sentences

    Word.create(word: params[:word], lang: params[:lang]) # will fail if Word already exists
    word = Word.find_by(word: params[:word], lang: params[:lang])

    GoogleBooksApiService.new(word).call

    render json: rendered_sentence(word.sentences.all)

  end


  def update_ranking

    ranking  = params[:ranking]
    sentence = Sentence.find_by(id: params[:id])
    
    sentence.rank(ranking)
       
    render json: rendered_sentence(sentence)
  end

  # add new sentence to list of sentences. If list is full (5 sentences), replace lowest-ranking sentence with this one.
  def new
     
    word = Word.find_by(word: params[:word], lang: params[:lang]) # Samantha: what if this word doesn't exist?

    sentence = Sentence.create(sentence: params[:sentence], word: word, ranking: 1)  
    word.add_sentence(sentence)
  
    render json: rendered_sentence(sentence)
  end

  private

  def sentence_params
    params.require(:sentence).permit(:word, :lang, :ranking)
  end

  def rendered_sentence(sentence) 
    renderer = JSONAPI::Serializable::Renderer.new 
    return renderer.render(sentence, class: {Sentence: SentenceSerializer})
  end
end
