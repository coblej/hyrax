module Hyrax
  class BatchCreateFailureService < AbstractMessageService
    attr_reader :user
    def initialize(user)
      @user = user
    end

    def message
      "The batch create for #{user} failed"
    end

    def subject
      'Failing batch create'
    end
  end
end
