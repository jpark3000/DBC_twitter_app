get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/tweet' do
  erb :single_user_tweet
end

post '/tweet' do
  begin
    tweet = CLIENT.update(params[:tweet])
  rescue
    "error"
  else
    "success"
  end
  # (tweet.nil?) ? "error" : "success"
end

post '/twitter_user' do

  @user = TwitterUser.find_or_create_by(username: params[:username])

  @user.fetch_tweets!
  @tweets = @user.tweets.order(tweet_id: :desc).limit(10)
  erb :_tweets
end





