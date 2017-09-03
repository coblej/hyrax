module Hyrax
  class NotificationsChannel < ApplicationCable::Channel
    def subscribed
      stream_from current_user.user_key
    end

    def unsubscribed
      stop_all_streams
    end
  end
end
