class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_day_ago, -> { where(created_at:  1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: Date.today..Date.today.days_ago(6)) }
  scope :created_last_week, -> { where(created_at: 1.week.ago..Date.today.days_ago(13)) }

  def self.get_created_days_ago(num)
    self.where(created_at: Date.today.days_ago(num).all_day)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
