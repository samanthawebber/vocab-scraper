module SentenceSorter

  RANKING_LIMIT = -3

  def ranking_below_limit?(ranking)

    if ranking <= RANKING_LIMIT
     return true
    end

    return false

  end

  def remove_if_low_ranking_sentence(sentence)
    
    if ranking_below_limit?(sentence.ranking)
      sentence.destroy
    end

  end


  def find_lowest_ranking
    lowest_ranking = sentences.first.ranking
    lowest_ranking_sentence = word.sentences.first

    for sentence in sentences do
      if sentence.ranking < lowest_ranking
        lowest_ranking = sentence.ranking
        lowest_ranking_sentence = sentence
      end
    end

    return lowest_ranking_sentence
  end

  # first check if Word already has 5 sentences; if so, remove lowest-ranking sentence and replace with new sentence.
  def add_sentence(new_sentence)
    if sentences.count >= 5
      lowest_ranking_sentence = find_lowest_ranking
      lowest_ranking_sentence.destroy
    end

    sentences << new_sentence
  end
end
