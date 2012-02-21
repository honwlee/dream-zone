class HomeController < ApplicationController
  def index
    @blogs = Blog.limit(3)
    @words = Word.limit(3)
  end
end
