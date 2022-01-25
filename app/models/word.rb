class Word < ApplicationRecord
  include SentenceSorter

  MAX_SENTENCE_LIMIT = 5
  ISO_639_CODES      = ['ab','aa','af','ak','sq','am','ar','an','hy','as','av','ae','ay','az','bm','ba','eu','be','bn','bh','bi','bs','br','bg','my','ca','km','ch','ce','ny','zh','cu','cv','kw','co','cr','hr','cs','da','dv','nl','dz','en','eo','et','ee','fo','fj','fi','fr','ff','gd','gl','lg','ka','de','ki','el','kl','gn','gu','ht','ha','he','hz','hi','ho','hu','is','io','ig','id','ia','ie','iu','ik','ga','it','ja','jv','kn','kr','ks','kk','rw','kv','kg','ko','kj','ku','ky','lo','la','lv','lb','li','ln','lt','lu','mk','mg','ms','ml','mt','gv','mi','mr','mh','ro','mn','na','nv','nd','ng','ne','se','no','nb','nn','ii','oc','oj','or','om','os','pi','pa','ps','fa','pl','pt','qu','rm','rn','ru','sm','sg','sa','sc','sr','sn','sd','si','sk','sl','so','st','nr','es','su','sw','ss','sv','tl','ty','tg','ta','tt','te','th','bo','ti','to','ts','tn','tr','tk','tw','ug','uk','ur','uz','ve','vi','vo','wa','cy','fy','wo','xh','yi','yo','za','zu'];

  has_many :sentences, before_add: :validate_sentence_limit, :dependent => :destroy

  validates :word, presence: true, uniqueness: { scope: :lang, case_sensitive: false }
  validates :lang, presence: true 
  validate  :lang_in_iso_codes

  private

  def validate_sentence_limit
    errors.add(:sentences, "cannot exceed 5 sentences.") if sentences.count >= MAX_SENTENCE_LIMIT
  end

  def lang_in_iso_codes
    errors.add(:lang, "must be a valid ISO-639 code.") if !ISO_639_CODES.include?(lang)
  end
end
