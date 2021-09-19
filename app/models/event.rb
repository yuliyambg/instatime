class Event < ApplicationRecord
  # belongs_to :user
  has_many :images, dependent: :destroy
  scope :public_events, -> { where(is_public: true) }


  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
