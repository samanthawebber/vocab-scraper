class WordsController < ApplicationController

  def show
     render json: JSONAPI::Serializable::Renderer.new.render(Word.find(params[:id]), class: {Word: WordSerializer}) 
  end

end
