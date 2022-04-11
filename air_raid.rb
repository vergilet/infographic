require 'httparty'
require 'nokogiri'
require "json"
require_relative 'tendentious'
require_relative 'race'
require_relative 'deaths_heals'

file = File.open "data/input.json"
input = JSON.load file

hash = {}
tendentious = []
deaths_heals = []
input.each do |post_id, post_date|
  next if post_id.is_a?(String)
  date = Time.new(*post_date)
  date = Time.parse(date.strftime('%Y-%m-%d %H:%M:%S UTC')).localtime
  post_number = post_id
  response = HTTParty.get("https://t.me/air_alert_ua/5142#{post_number}?embed=1")

  pp "PostID:#{ post_id }, Date: #{ post_date }, GET: #{response.message}, Code: #{ response.code }"

  parsed_data = Nokogiri::HTML.parse(response.body)
  text = parsed_data.at_css('div.js-message_text')&.text&.strip

  if text.nil?
    raise StandardError.new("#{post_id} ERROR")
  else
    pp "Text present. Starting Tendentious parsing ..."
  end

  tendentious << Tendentious.new(post_date, text).call
  pp "Tendentious parsed!"

  pp "Parsing Oblasti ..."
  new = Race.new(text).call
  new << { "id": "UA-40", "value": 0, "name": "Севастополь", "en_name": "Sevastopol" }
  new << { "id": "UA-43", "value": 0, "name": "Крим", "en_name": "Crimea" }

  hash["#{date.to_time.to_i}000"] = new
  pp "Oblasti parsed!"


  pp "Deaths / Heals parsing ..."
  deaths_heals = DeathsHeals.new(text).call
  pp "Deaths / Heals parsed!"
  pp '================'
end


# JSON GENERATION

last_key = hash.keys.max
pp "Last date detecting: #{last_key} - #{Time.at(last_key[0..-4].to_i).utc}"
pp "Write data.json"
File.open("data/data.json","w") do |f|
  f.write(hash[last_key].to_json)
end
pp "Done data.json"


pp 'Write experiments.json'
File.open('data/experiments.json', 'w') do |f|
  f.write(deaths_heals.to_json)
end
pp 'Done experiments.json'
