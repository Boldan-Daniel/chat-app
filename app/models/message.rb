class Message < ApplicationRecord
  belongs_to :user

  scope :for_display, -> { order(:created_at).last(50) }

  validates :content, presence: true

  def mentions
    content.scan(/@(#{User::NAME_REGEX})/).flatten.map do |username|
      User.find_by_username(username)
    end.compact
  end
end
