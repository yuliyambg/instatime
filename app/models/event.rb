class Event < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy

  scope :public_events, -> { where(is_public: true) }
  scope :private_events, -> { where(is_public: false)}
  scope :user_public_events, ->(current_user) {public_events.where(user_id: current_user.id)}
  scope :user_private_events, ->(current_user) {private_events.where(user_id: current_user.id)}

  validates :description, presence: true
end
