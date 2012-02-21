class WordsController < ApplicationController
	def index
		@words = Word.page(params[:page] || 1).per(20)
	end
end
