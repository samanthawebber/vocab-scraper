class WordSerializer < JSONAPI::Serializable::Resource

    type 'word'
      attributes :word, :sentences
end
