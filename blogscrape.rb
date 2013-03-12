require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

blog = Nokogiri::HTML(open('http://blog.shopittome.com/'))
posts = []

blog.css('h2 a').each do |title, post|
    post = {}
    post['title'] = title.content
    post['images'] = []
    posts.push post
end

i = 0
blog.css('div.format_text').each do |post|
    post.css('img').each do |img|
        posts[i]['images'].push img.attributes['src']
    end
    i+=1
end

i = 1
posts.each do |post|
    puts "\n\n#{i}. #{post['title']}\n\n"
    post['images'].each do |img|
        puts "-#{img}\n\n"
    end
    i+=1
end
