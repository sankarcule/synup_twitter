class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :replied_tweets, class_name:  "Tweet",
                                 foreign_key: "tweet_id",
                                 dependent:   :destroy
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments

end
