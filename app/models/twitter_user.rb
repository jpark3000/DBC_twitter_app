class TwitterUser < ActiveRecord::Base
  has_many :tweets


  def new_tweets
    db_last_tweet_id = self.tweets.order(tweet_id: :desc).first.tweet_id.to_i
    CLIENT.user_timeline(self.username, since_id: db_last_tweet_id)
  end

  def fetch_tweets!
    if !(self.tweets.exists?)
      tweets = CLIENT.user_timeline(self.username)
    else
      tweets = new_tweets
      return true if tweets.empty?
    end

    populate_tweet_db(tweets)
    false
  end

  def populate_tweet_db(tweet_array)
    tweet_array.each do |tweet|
      self.tweets << Tweet.create(tweet: tweet.text, tweet_id: tweet.id.to_s)
    end
  end



end
