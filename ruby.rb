require 'httparty'
require 'nokogiri'


input = [
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
  [618, [2020, 5, 23]]
]
hash = {}
fix_array = []
input.each do |post_id, post_date|

  date = Time.new(*post_date)
  date = Time.parse(date.strftime('%Y-%m-%d %H:%M:%S UTC')).localtime
  post_number = post_id
  response = HTTParty.get("https://t.me/COVID19_Ukraine/#{post_number}?embed=1")

  parsed_data = Nokogiri::HTML.parse(response.body)
  text = parsed_data.at_css('div.js-message_text').text.strip

  # Fixation
  fixation = text.split(':')[2]
  fix = fixation.split('.')[1]
  fix.slice!(' За добу зафіксовано ')
  fix.slice!(' нові випадки')
  fix_array << { date: "#{post_date[0]}-#{post_date[1]}-#{post_date[2]}", value: fix.to_i }
  # end fixation

  arr = text.split(':')[3].split(';')

  new = arr.map do |oblast|
    text = oblast
    if oblast.match('Вінницька область — ')
      text.slice!('Вінницька область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-05", "value": text.to_i.to_i, "name": "Вінницька", "en_name": "Vinnytsia" }
    elsif oblast.match('Волинська область — ')
      text.slice!('Волинська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-07", "value": text.to_i, "name": "Волинська", "en_name": "Volyn" }
    elsif oblast.match('Дніпропетровська область — ')
      text.slice!('Дніпропетровська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-12", "value": text.to_i, "name": "Дніпропетровська", "en_name": "Dnipropetrovsk" }
    elsif oblast.match('Донецька область — ')
      text.slice!('Донецька область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-14", "value": text.to_i, "name": "Донецька", "en_name": "Donetsk" }
    elsif oblast.match('Житомирська область — ')
      text.slice!('Житомирська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-18", "value": text.to_i, "name": "Житомирська", "en_name": "Zhytomyr" }
    elsif oblast.match('Закарпатська область — ')
      text.slice!('Закарпатська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-21", "value": text.to_i, "name": "Закарпатська", "en_name": "Zakarpattia" }
    elsif oblast.match('Запорізька область — ')
      text.slice!('Запорізька область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-23", "value": text.to_i, "name": "Запорізька", "en_name": "Zaporizhzhya" }
    elsif oblast.match('Івано-Франківська область — ')
      text.slice!('Івано-Франківська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-26", "value": text.to_i, "name": "Івано-Франківська", "en_name": "Ivano-Frankivsk" }
    elsif oblast.match('Кіровоградська область — ')
      text.slice!('Кіровоградська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-35", "value": text.to_i, "name": "Кіровоградська", "en_name": "Kirovohrad" }
    elsif oblast.match('м. Київ — ')
      text.slice!('м. Київ — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-30", "value": text.to_i, "name": "м. Київ", "en_name": "Kiev City" }
    elsif oblast.match('Київська область — ')
      text.slice!('Київська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-32", "value": text.to_i, "name": "Київська", "en_name": "Kiev" }
    elsif oblast.match('Львівська область — ')
      text.slice!('Львівська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-46", "value": text.to_i, "name": "Львівська", "en_name": "Lviv" }
    elsif oblast.match('Луганська область — ')
      text.slice!('Луганська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-09", "value": text.to_i, "name": "Луганська", "en_name": "Luhansk" }
    elsif oblast.match('Миколаївська область — ')
      text.slice!('Миколаївська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-48", "value": text.to_i, "name": "Миколаївська", "en_name": "Mykolaiv" }
    elsif oblast.match('Одеська область — ')
      text.slice!('Одеська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-51", "value": text.to_i, "name": "Одеська", "en_name": "Odessa" }
    elsif oblast.match('Полтавська область — ')
      text.slice!('Полтавська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-53", "value": text.to_i, "name": "Полтавська", "en_name": "Poltava" }
    elsif oblast.match('Рівненська область — ')
      text.slice!('Рівненська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-56", "value": text.to_i, "name": "Рівненська", "en_name": "Rivne" }
    elsif oblast.match('Сумська область — ')
      text.slice!('Сумська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-59", "value": text.to_i, "name": "Сумська", "en_name": "Sumy" }
    elsif oblast.match('Тернопільська область — ')
      text.slice!('Тернопільська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-61", "value": text.to_i, "name": "Тернопільська", "en_name": "Ternopil" }
    elsif oblast.match('Харківська область — ')
      text.slice!('Харківська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-63", "value": text.to_i, "name": "Харківська", "en_name": "Kharkiv" }
    elsif oblast.match('Херсонська область — ')
      text.slice!('Херсонська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-65", "value": text.to_i, "name": "Херсонська", "en_name": "Kherson" }
    elsif oblast.match('Хмельницька область — ')
      text.slice!('Хмельницька область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-68", "value": text.to_i, "name": "Хмельницька", "en_name": "Khmelnytskyi" }
    elsif oblast.match('Чернівецька область — ')
      text.slice!('Чернівецька область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-77", "value": text.to_i, "name": "Чернівецька", "en_name": "Chernivtsi" }
    elsif oblast.match('Черкаська область — ')
      text.slice!('Черкаська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      { "id": "UA-71", "value": text.to_i, "name": "Черкаська", "en_name": "Cherkasy" }
    elsif oblast.match('Чернігівська область — ')
      text.slice!('Чернігівська область — ')
      text.slice!(' випадків')
      text.slice!(' випадки')
      text.slice!(' випадок')
      text = text.split('.')[0]
      { "id": "UA-74", "value": text.to_i, "name": "Чернігівська", "en_name": "Chernihiv" }
    end
  end

  new << { "id": "UA-40", "value": 0, "name": "Севастополь", "en_name": "Sevastopol" }
  new << { "id": "UA-43", "value": 0, "name": "Крим", "en_name": "Crimea" }

  hash["#{date.to_time.to_i}000"] = new
end

File.open("data/race-auto.json","w") do |f|
  f.write(hash.to_json)
end

File.open("data/tendentious.json","w") do |f|
  f.write(fix_array.to_json)
end

last_key = hash.keys.max
File.open("data/data.json","w") do |f|
  f.write(hash[last_key].to_json)
end

