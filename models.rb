class User < ActiveRecord::Base

	def full_name
		if fname && lname
			fname + ' ' + lname
		elsif fname
			fname
		elsif lname
			lname
		else
			nil
		end
	end

	attr_accessor :password

	before_save :encrypt_password

	def encrypt_password
		if self.password.present?
			self.password_salt = BCrypt::Engine.generate_salt
      		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      	end
    end

    def self.authenticate(email, password)
	    user = find_by_email(email) #or User.where(email: email).first - looking up a user by the assigned email.
	    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
	      user
	    else
	      nil
	    end
	end

    has_many :posts
    has_many :relationships, foreign_key: :follower_id
    has_many :followed_users, through: :relationships, source: :follower
    has_many :reverse_relationships, foreign_key: :followed_id, class_name: "Relationship"
    has_many :followers, through: :reverse_relationships
 end

class Post < ActiveRecord::Base

	belongs_to :user

end

class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"




end