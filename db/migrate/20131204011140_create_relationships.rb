class CreateRelationships < ActiveRecord::Migration
  def up
  	create_table :relationships do |c|
  		c.integer :follower_id
  		c.integer :followed_id
  end
end

  def down
  	drop_table :relationships 
  end
end


#create a tags table too: name, timestamps (this needs a join table too, like Relationships for users and posts)
#this PostTags table would include tag_id and post_id