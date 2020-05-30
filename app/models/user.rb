class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  #バリデーション追加
  validates :email, presence: true
  validates :name, presence: true

  #SNS認証
  has_many :sns_credentials, dependent: :destroy

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

  # def self.from_omniauth(auth)
  #   sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
  #   user = sns.user || User.where(email: auth.info.email,).first_or_initialize(
  #     nick_name: auth.info.name,
  #       email:auth.info.email
  #   )
  #   if user.persisted?
  #     sns.user = user
  #     sns.save
  #   end
  #   { user: user, sns: sns }
  # end

  #SNS認証
  def self.without_sns_data(auth)

    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
          )
      else
        user = User.new(
          name: auth.info.name,
          email: auth.info.email
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
   user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email
      )
    end
    return {user: user}
  end

 def self.find_oauth(auth)
  uid = auth.uid
  provider = auth.provider
  snscredential = SnsCredential.where(uid: uid, provider: provider).first
  if snscredential.present?
    user = with_sns_data(auth, snscredential)[:user]
    sns = snscredential
  else
    user = without_sns_data(auth)[:user]
    sns = without_sns_data(auth)[:sns]
  end
  return { user: user ,sns: sns}
  end

end
