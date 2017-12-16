class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "following_id",
                                 dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :tweets
  enum gender: [:male, :female]
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments

  has_attached_file :profile_pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\z/
end
