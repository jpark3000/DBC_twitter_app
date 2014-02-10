get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by(username: params[:username])
  if @user.tweets.empty?
    @user.fetch_tweets!
  end

  if @user.tweets_stale?
    @user.fetch_new_tweets!
  end

  @tweets = @user.tweets.sort_by { |tweet| tweet.tweet_id }
  erb :tweets
end
