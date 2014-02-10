class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def new_tweets
    db_last_tweet_id = self.tweets.order(tweet_id: :desc).first.tweet_id.to_i
    new_tweets_array = CLIENT.user_timeline(self.username, since_id: db_last_tweet_id)

    return if new_tweets_array.empty?

    populate_tweet_db(new_tweets_array)
  end

  def fetch_tweets!
    tweet_arr = CLIENT.user_timeline(self.username)
    populate_tweet_db(tweet_arr)
  end

  def populate_tweet_db(tweet_array)
    tweet_array.each do |tweet|
      self.tweets << Tweet.create(tweet: tweet.text, tweet_id: tweet.id.to_s)
    end
  end



end
