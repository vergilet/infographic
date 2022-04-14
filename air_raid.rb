require 'httparty'
require 'nokogiri'
require "json"
require 'git'

file = File.open "data/air.json"
@template = JSON.load(file)

def process_post(post_id)
  p post_id
  url = "https://t.me/air_alert_ua/#{post_id}"
  response = HTTParty.get(url)

  parsed_data = Nokogiri::HTML.parse(response.body)
  text = parsed_data.at('meta[property="og:description"]')["content"] rescue nil
  return if text.nil?
  @next_post_id ||= @last_post

  if text.nil? || text.include?("Офіційний канал, що інформує про повітряну тривогу в будь-якому регіоні України.")
    File.open("data/last_post.json","w") do |f|
      f.write({ post: post_id, time: Time.now.getlocal('+03:00').strftime('%d-%m-%Y %T (UA)') }.to_json)
    end
    if (@next_post_id + 10) < post_id
      return @next_post_id
    else
      return post_id + 1
    end
  else
    post_id = @next_post_id
  end

  hashtags = text.scan(/\s(#[[:graph:]]+)/).flatten.map{ |s| s.strip[1..-1] }

  pp hashtags
  hashtags.each do |hashtag|
    obl_hash = @template.find{|obl| obl["name"].split('-').join('') == hashtag.split('_').join(' ').gsub('м ', '')}
    next if obl_hash.nil?
    @template -= [obl_hash]
    if text.include?("🔴")
      p "🔴"
      obl_hash["time"] = text[2..7]
      obl_hash["value"] = 1
      obl_hash["fill"] = '#ff968a'
    elsif text.include?("🟢")
      p "🟢"
      obl_hash["time"] = text[2..7]
      obl_hash["value"] = 0
      obl_hash["fill"] = '#97c1a9'
    elsif text.include?("🟡") && text.include?("Відбій тривоги в")
      p "🟡"
      obl_hash["time"] = text[2..7]
      obl_hash["value"] = 0
      obl_hash["fill"] = '#97c1a9'
    else
      next
    end
    @template += [obl_hash]
  end
  # JSON GENERATION

  File.open("data/air.json","w") do |f|
    f.write(@template.to_json)
  end

  @next_post_id = post_id + 1
  File.open("data/last_post.json","w") do |f|
    f.write({ post: @next_post_id, time: Time.now.getlocal('+03:00').strftime('%d-%m-%Y %T (UA)') }.to_json)
  end
end


last_post_file = File.open "data/last_post.json"
@last_post = JSON.load(last_post_file)&.dig("post")

while @last_post.nil? do
  sleep 5
  @last_post = JSON.load(last_post_file)&.dig("post")
end

@post_id = @last_post

process_post(@post_id)
puts Time.now

