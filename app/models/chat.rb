class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  before_create :set_number

  private

  def set_number
    self.number = (application.chats.maximum(:number) || 0) + 1
  end
end
