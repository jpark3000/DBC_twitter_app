get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/twitter_user' do

  @user = TwitterUser.find_or_create_by(username: params[:username])

  @user.fetch_tweets!
  @tweets = @user.tweets.order(tweet_id: :desc).limit(10)
  erb :_tweets
end





