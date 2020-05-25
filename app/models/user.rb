class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション追加
  validates :email, presence: true
  validates :name, presence: true

  attachment :profile_image
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy#フォロー機能
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy#フォロワー機能
  has_many :following_user, through: :follower, source: :followed#自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower#自分がフォローしている人

  #ユーザーをフォローする
  def follow(user_id)
  	follower.create(followed_id: user_id)
  end
  #ユーザーのフォローを外す
  def unfollow(user_id)
  	follower.find_by(followed_id: user_id).destroy
  end
  #フォローしていればtrueを返す
  def following?(user)
  	following_user.include?(user)
  end

  def post_images
    return PostImage.where(user_id: self.id)
  end

end
