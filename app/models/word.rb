class Word
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :property
  embeds_many :acceptations
  embeds_many :word_names

  field :level, :type => String
end

class Acceptation
  include Mongoid::Document
  embedded_in :word
  field :content, :type => String
end

class WordName
  include Mongoid::Document
  embedded_in :word

  field :content, :type => String
  field :usage, :type => Integer # 0 ---> zh 1 ---> jp 2 ---> en
  index :usage
  index :content
end
