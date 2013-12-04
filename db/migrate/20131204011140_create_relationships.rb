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
