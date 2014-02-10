get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by(username: params[:username])
  if @user.tweets.empty?
    @user.fetch_tweets!
  end

  @user.new_tweets

  @tweets = @user.tweets.order(tweet_id: :desc).limit(10)
  erb :tweets
end
