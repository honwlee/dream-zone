class Word
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :property
  embeds_many :acceptations
  embeds_many :word_names

  field :level, :type => String

  def zh_name
    word_names.zh_name.collect{|n|n.content}
  end

  def jp_name
    word_names.jp_name.collect{|n| n.content}
  end

  def ciyi
    acceptations.collect{|a| a.content}.join(',')
  end

  def cixing
    property.name
  end
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

  scope :zh_name, :where => {:usage => 0}
  scope :jp_name, :where => {:usage => 1}
end
