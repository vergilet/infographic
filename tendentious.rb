class Tendentious
  def initialize(post_date, message)
    @post_date = post_date
    @message = message
  end

  def call
    tendentious = @message.split(':')[2].split('.')[1]
    tendentious.slice!(' За добу зафіксовано ')
    tendentious.slice!(' нові випадки')
    { date: "#{date_format}", value: tendentious.to_i }
  end

  private

  attr_reader :post_date, :message

  def date_format
    "#{post_date[0]}-#{post_date[1]}-#{post_date[2] < 10 ? '0' : ''}#{post_date[2]}"
  end
end