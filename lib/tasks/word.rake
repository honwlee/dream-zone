# encoding: utf-8
require 'spreadsheet'
require 'roo'
require 'csv'
namespace :word do
	task :import => :environment do
		s = Excel.new(ENV['file'])
		#result = File.read('result.txt')
		puts s
	  ("#{s.first_row}..#{s.last_row}").each do |i|
	  	puts i
	  	unless s.row(i).blank?
	  		puts s.row(i)[0]
	      word = Word.new

	      word.cixing = s.row(i)[2] unless s.row(i)[2].blank?

	      word.word_names << WordName.new(:usage => 0, :content => s.row(i)[0]) unless s.row(i)[0].blank?

	      word.word_names << WordName.new(:usage => 1, :content => s.row(i)[1]) unless s.row(i)[1].blank?

	      s.row(i)[3].split(';').each do |acceptation|
	      	word.acceptation << Acceptation.new(:content => acceptation)
	      end unless s.row(i)[3].blank?

	      word.save
	  	end
    end
		
	end

	task :parse_csv => :environment do
		Rails.logger.debug 1111111111111111111111111111
		Rails.logger.debug Rails.root
		root_path = "/data/"
		file_name = ["result.csv","results(1-2).csv"]
		#file_name = "result.csv"
		file_name.each do |f_n|
			CSV.open(root_path + f_n,'r') do |results|
				i = 0
				results.each do |v|
	        word = Word.new
	        puts v[0] + ',' + v[1] + ',' + v[2] + ',' + v[3]
	        word.level = "N1~N2"

		      word.property = Property.find_or_create_by(:name => v[2])
		      
		      word.save
		       
	        zh_name = WordName.new(:usage => 0, :content => v[0])
	        word.word_names <<  zh_name unless v[0].blank?
	        
	        jp_name = WordName.new(:usage => 1, :content => v[1])
		      word.word_names <<  jp_name unless v[1].blank?

		      v[3].split("；").each do |acceptation|
		      	acceptation = Acceptation.new(:content => acceptation)
		      	word.acceptations << acceptation
		      end unless v[3].blank?

		      puts i
		      i += 1
	      end
			end
    end
  end

end