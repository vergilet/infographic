require 'httparty'
require 'nokogiri'
require_relative 'tendentious'
require_relative 'race'
require_relative 'deaths_heals'


input = [
  [293, [2020, 4, 4]],
  [298, [2020, 4, 5]],
  [304, [2020, 4, 6]],
  [313, [2020, 4, 7]],
  [325, [2020, 4, 8]],
  [333, [2020, 4, 9]],
  [340, [2020, 4, 10]],
  # [347, [2020, 4, 11]], # bad tg message format
  [354, [2020, 4, 12]],
  [363, [2020, 4, 13]],
  [372, [2020, 4, 14]],
  [378, [2020, 4, 15]],
  [388, [2020, 4, 16]],
  [395, [2020, 4, 17]],
  [401, [2020, 4, 18]],
  [407, [2020, 4, 19]],
  [410, [2020, 4, 20]],
  [414, [2020, 4, 21]],
  [420, [2020, 4, 22]],
  [433, [2020, 4, 23]],
  [439, [2020, 4, 24]],
  [443, [2020, 4, 25]],
  [450, [2020, 4, 26]],
  [454, [2020, 4, 27]],
  [461, [2020, 4, 28]],
  [467, [2020, 4, 29]],
  [474, [2020, 4, 30]],
  [479, [2020, 5, 1]],
  [486, [2020, 5, 2]],
  [492, [2020, 5, 3]],
  [497, [2020, 5, 4]],
  [507, [2020, 5, 5]],
  [513, [2020, 5, 6]],
  [519, [2020, 5, 7]],
  [528, [2020, 5, 8]],
  [536, [2020, 5, 9]],
  [542, [2020, 5, 10]],
  [546, [2020, 5, 11]],
  [550, [2020, 5, 12]],
  [554, [2020, 5, 13]],
  [563, [2020, 5, 14]],
  [568, [2020, 5, 15]],
  [574, [2020, 5, 16]],
  [579, [2020, 5, 17]],
  [584, [2020, 5, 18]],
  [590, [2020, 5, 19]],
  [596, [2020, 5, 20]],
  [602, [2020, 5, 21]],
  [613, [2020, 5, 22]],
  [618, [2020, 5, 23]],
  [623, [2020, 5, 24]]
]
hash = {}
tendentious = []
deaths_heals = []
input.each do |post_id, post_date|

  date = Time.new(*post_date)
  date = Time.parse(date.strftime('%Y-%m-%d %H:%M:%S UTC')).localtime
  post_number = post_id
  response = HTTParty.get("https://t.me/COVID19_Ukraine/#{post_number}?embed=1")

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

pp "Write race-auto.json"
File.open("data/race-auto.json","w") do |f|
  f.write(hash.to_json)
end
pp "Done race-auto.json!"

pp "Write tendentious.json"
File.open("data/tendentious.json","w") do |f|
  f.write(tendentious.to_json)
end
pp "Done tendentious.json"

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