class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: Time.zone.now.all_week) }
  scope :created_last_week, -> { where(created_at: 1.week.ago.all_week) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end