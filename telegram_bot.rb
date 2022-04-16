require 'telegram/bot'

group = ThreadGroup.new
group.add(
  Thread.new do
    Telegram::Bot::Client.run(TG_CONFIG["token"]) do |bot|
      bot.listen do |message|
        Telegramer::Receiver.call(message, bot)
      end
    end
  end
)
