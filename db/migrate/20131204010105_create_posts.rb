class CreatePosts < ActiveRecord::Migration
  def up
  	create_table :posts do |c|
  		c.integer :user_id
  		c.string :title
  		c.text :body
  		c.timestamps
  	end
  end

  def down
  	drop_table :posts 
  end
end
