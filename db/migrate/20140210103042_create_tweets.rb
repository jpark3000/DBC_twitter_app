class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet
      t.string :tweet_id
      t.belongs_to :twitter_user
      t.timestamps
    end
  end
end
