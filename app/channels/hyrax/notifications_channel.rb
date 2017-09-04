module Hyrax
  class NotificationsChannel < ApplicationCable::Channel
    def subscribed
      stream_for current_user
    end

    def unsubscribed
      stop_all_streams
    end
  end
end
