class Race
  def initialize(message)
    @message = message
  end

  def call
    array.map do |oblast|
      process(oblast)
    end
  end

  private

  attr_reader :post_date, :message

  def array
    message.split(':')[3].split(';')
  end

  def process(oblast)
    text = oblast
    if oblast.match('Вінницька область — ')
      text.slice!('Вінницька область — ')
      slicer(text)
      { "id": "UA-05", "value": text.to_i, "name": "Вінницька", "en_name": "Vinnytsia" }
    elsif oblast.match('Волинська область — ')
      text.slice!('Волинська область — ')
      slicer(text)
      { "id": "UA-07", "value": text.to_i, "name": "Волинська", "en_name": "Volyn" }
    elsif oblast.match('Дніпропетровська область — ')
      text.slice!('Дніпропетровська область — ')
      slicer(text)
      { "id": "UA-12", "value": text.to_i, "name": "Дніпропетровська", "en_name": "Dnipropetrovsk" }
    elsif oblast.match('Донецька область — ')
      text.slice!('Донецька область — ')
      slicer(text)
      { "id": "UA-14", "value": text.to_i, "name": "Донецька", "en_name": "Donetsk" }
    elsif oblast.match('Житомирська область — ')
      text.slice!('Житомирська область — ')
      slicer(text)
      { "id": "UA-18", "value": text.to_i, "name": "Житомирська", "en_name": "Zhytomyr" }
    elsif oblast.match('Закарпатська область — ')
      text.slice!('Закарпатська область — ')
      slicer(text)
      { "id": "UA-21", "value": text.to_i, "name": "Закарпатська", "en_name": "Zakarpattia" }
    elsif oblast.match('Запорізька область — ')
      text.slice!('Запорізька область — ')
      slicer(text)
      { "id": "UA-23", "value": text.to_i, "name": "Запорізька", "en_name": "Zaporizhzhya" }
    elsif oblast.match('Івано-Франківська область — ')
      text.slice!('Івано-Франківська область — ')
      slicer(text)
      { "id": "UA-26", "value": text.to_i, "name": "Івано-Франківська", "en_name": "Ivano-Frankivsk" }
    elsif oblast.match('Кіровоградська область — ')
      text.slice!('Кіровоградська область — ')
      slicer(text)
      { "id": "UA-35", "value": text.to_i, "name": "Кіровоградська", "en_name": "Kirovohrad" }
    elsif oblast.match('м. Київ — ')
      text.slice!('м. Київ — ')
      slicer(text)
      { "id": "UA-30", "value": text.to_i, "name": "Київ", "en_name": "Kiev City" }
    elsif oblast.match('Київська область — ')
      text.slice!('Київська область — ')
      slicer(text)
      { "id": "UA-32", "value": text.to_i, "name": "Київська", "en_name": "Kiev" }
    elsif oblast.match('Львівська область — ')
      text.slice!('Львівська область — ')
      slicer(text)
      { "id": "UA-46", "value": text.to_i, "name": "Львівська", "en_name": "Lviv" }
    elsif oblast.match('Луганська область — ')
      text.slice!('Луганська область — ')
      slicer(text)
      { "id": "UA-09", "value": text.to_i, "name": "Луганська", "en_name": "Luhansk" }
    elsif oblast.match('Миколаївська область — ')
      text.slice!('Миколаївська область — ')
      slicer(text)
      { "id": "UA-48", "value": text.to_i, "name": "Миколаївська", "en_name": "Mykolaiv" }
    elsif oblast.match('Одеська область — ')
      text.slice!('Одеська область — ')
      slicer(text)
      { "id": "UA-51", "value": text.to_i, "name": "Одеська", "en_name": "Odessa" }
    elsif oblast.match('Полтавська область — ')
      text.slice!('Полтавська область — ')
      slicer(text)
      { "id": "UA-53", "value": text.to_i, "name": "Полтавська", "en_name": "Poltava" }
    elsif oblast.match('Рівненська область — ')
      text.slice!('Рівненська область — ')
      slicer(text)
      { "id": "UA-56", "value": text.to_i, "name": "Рівненська", "en_name": "Rivne" }
    elsif oblast.match('Сумська область — ')
      text.slice!('Сумська область — ')
      slicer(text)
      { "id": "UA-59", "value": text.to_i, "name": "Сумська", "en_name": "Sumy" }
    elsif oblast.match('Тернопільська область — ')
      text.slice!('Тернопільська область — ')
      slicer(text)
      pp text
      { "id": "UA-61", "value": text.to_i, "name": "Тернопільська", "en_name": "Ternopil" }
    elsif oblast.match('Харківська область — ')
      text.slice!('Харківська область — ')
      slicer(text)
      { "id": "UA-63", "value": text.to_i, "name": "Харківська", "en_name": "Kharkiv" }
    elsif oblast.match('Херсонська область — ')
      text.slice!('Херсонська область — ')
      slicer(text)
      { "id": "UA-65", "value": text.to_i, "name": "Херсонська", "en_name": "Kherson" }
    elsif oblast.match('Хмельницька область — ')
      text.slice!('Хмельницька область — ')
      slicer(text)
      { "id": "UA-68", "value": text.to_i, "name": "Хмельницька", "en_name": "Khmelnytskyi" }
    elsif oblast.match('Чернівецька область — ')
      text.slice!('Чернівецька область — ')
      slicer(text)
      { "id": "UA-77", "value": text.to_i, "name": "Чернівецька", "en_name": "Chernivtsi" }
    elsif oblast.match('Черкаська область — ')
      text.slice!('Черкаська область — ')
      slicer(text)
      { "id": "UA-71", "value": text.to_i, "name": "Черкаська", "en_name": "Cherkasy" }
    elsif oblast.match('Чернігівська область — ')
      text.slice!('Чернігівська область — ')
      slicer(text)
      text = text.split('.')[0] # cut rest text
      { "id": "UA-74", "value": text.to_i, "name": "Чернігівська", "en_name": "Chernihiv" }
    end
  end

  def slicer(text)
    text.slice!(' випадків')
    text.slice!(' випадки')
    text.slice!(' випадок')
  end
end
