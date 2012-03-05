require 'rubygems'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'rainbow'
source = "http://nostarch.com/blog/?feed=rss2"
#source = "http://home.e-doctor.cn/feed"
source = "http://www.thelancet.com/rssfeed/lancet_current.xml"
content = ""

open(source) do |info|
  content = info.read
end

rss = RSS::Parser.parse(content, false)

print "是否需要查看feed的简介(y/n)?".underline.bright
input = gets.chomp

desc = input == 'y' || input == 'Y'

puts "\n\nTITLE: #{rss.channel.title}".foreground(:magenta)
puts "DESCRIPTION: #{rss.channel.description}".foreground(:yellow)
puts "LINK: #{rss.channel.link}".underline.bright
puts "PUBLICATION DATE: #{Time.now} \n\n".background(:red)

rss.items.size.times do |i|
  puts "#{Time.now} <----> #{rss.items[i].title}".background(:green)
  if desc
    print "#{rss.items[i].description}\n\n\n".foreground(:blue)
  end
end

