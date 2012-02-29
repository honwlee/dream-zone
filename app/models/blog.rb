class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title
  field :abstract
end
