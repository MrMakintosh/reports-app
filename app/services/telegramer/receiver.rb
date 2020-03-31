module Telegramer
  class Receiver < ApplicationService
    attr_reader :message, :bot

    def initialize(message, bot)
      @message = message
      @bot = bot
    end

    def call
      user = User.find_by(chat_id: @message.chat.id)
      case @message.text
        when '/start'
          unless user
            @bot.api.send_message(text: I18n.t('telegramer.messages.greeting'), chat_id: @message.chat.id)
          end
          @bot.api.send_message(text: I18n.t('telegramer.messages.instruction'), chat_id: @message.chat.id)
        when '/stop'
          return unless user
          user.update chat_id: nil
          @bot.api.send_message(text: I18n.t('telegramer.messages.notification_disabled'), chat_id: @message.chat.id)
        when URI::MailTo::EMAIL_REGEXP
          return if user
          user = User.find_by(email: @message.text)
          if user&.update chat_id: @message.chat.id
            @bot.api.send_message(text: I18n.t('telegramer.messages.notification_enabled'), chat_id: @message.chat.id)
          else
            @bot.api.send_message(text: I18n.t('telegramer.errors.mail_not_found'), chat_id: @message.chat.id)
          end
        else
          @bot.api.send_message(chat_id: @message.chat.id, text: I18n.t('telegramer.errors.did_not_understand'))
      end
    end
  end
end
