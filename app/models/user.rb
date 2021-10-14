class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :relationships, foreign_key: :follow_id 
  has_many :follow, through: :relationships, source: :followed 
  has_many :reverse_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :followed, through: :reverse_relationships, source: :follow
  
  
  
  attachment :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

end
