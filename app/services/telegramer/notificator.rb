require 'telegram/bot'

module Telegramer
  class Notificator < ApplicationService
    attr_reader :user

    def initialize(user)
      @user = user
      @admins = User.where(admin: 1)
    end

    def call
      ThreadGroup.new.add(
        Thread.new do
          Telegram::Bot::Client.run(TG_CONFIG["token"]) do |bot|
            @admins.each do |admin|
              unless admin.chat_id.nil?
                bot.api.send_message(chat_id: admin.chat_id, text: I18n.t('telegramer.messages.new_request', user_name: "#{@user.name} #{@user.surname}", cabinet: @user.cabinet))
              end
            end
          end
        end
      )
    end
  end
end
