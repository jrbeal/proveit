class Prover < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	COLLAPSED = "collapsed"
	EXPANDED = "expanded"

	before_create do 								# Initialize the new user
		self.verbosity = 3
		self.offspring_collapsed = TRUE
		self.default_filter = COLLAPSED
		self.rating = 0
		self.percentile = 0
	end
end
