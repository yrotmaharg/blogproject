class CreateUsers < ActiveRecord::Migration
  def up
  	create_table :users do |c|

  		c.string :fname
  		c.string :lname
  		c.string :username
  		c.string :email
  		c.timestamps 
  		c.string :password_hash
  		c.string :password_salt
 	end
   end

  def down
  	drop_table :users
  end
end
