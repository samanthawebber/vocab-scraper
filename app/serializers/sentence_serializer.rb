class SentenceSerializer < JSONAPI::Serializable::Resource

  type 'sentence'
  attributes :sentence, :ranking, :word
end
