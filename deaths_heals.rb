class DeathsHeals
  def initialize(text)
    @text = text
    @colors = ["#673ab7", "#e91e63", "#9c27b0", "#505050"]
  end

  def call
    fixed = detector[0]
    fixed.slice!(' лабораторно підтверджених випадків COVID-19')

    deaths = detector[1]
    deaths.slice!(' з них ')
    deaths.slice!(' летальних')

    heals = detector[2]
    heals.slice!(' пацієнти одужали')
    heals.gsub!(/\s+/, "")

    [
      # { "country": "Досліджень", "visits": 277712, "color": @colors[0] },
      { "country": "Захворіли", "visits": fixed.to_i, "color": @colors[1] },
      { "country": "Одужали", "visits": heals.to_i, "color": @colors[2] },
      { "country": "Померли", "visits": deaths.to_i, "color": @colors[3] }
    ]
  end

  attr_reader :text

  def detector
    @detector ||= parsed_array[0].split(',')
  end

  def parsed_array
    @parsed_array ||= text.split('в Україні ')[1].split('.')
  end
end
