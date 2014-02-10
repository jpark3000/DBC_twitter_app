class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def new_tweets
    db_last_tweet_id = self.tweets.sort_by { |tweet| tweet.tweet_id }.last.tweet_id
    CLIENT.user_timeline(self.username, since_id: db_last_tweet_id.to_i)
  end

  def tweets_stale?
    new_tweets.any?
  end

  def fetch_new_tweets!
    new_tweet_arr = new_tweets
    populate_tweet_db(new_tweets)
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
