class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

  before_create :set_number

  private

  def set_number
    self.number = (chat.messages.maximum(:number) || 0) + 1
  end
end
