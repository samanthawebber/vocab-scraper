Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/sentences/:id',       to: "sentences#show"
  get  '/generate_sentences', to: "sentences#generate_sentences"
  put '/sentences/:id',       to: "sentences#update_ranking"
  post '/sentences',          to: "sentences#post_sentence"

end
