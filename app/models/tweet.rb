class Tweet < ApplicationRecord
  belongs_to :user
  has_many   :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    image.attached?
  end
end
