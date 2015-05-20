class Prover < ActiveRecord::Base
	has_many :filters, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_and_belongs_to_many :groups, dependent: :destroy
	has_and_belongs_to_many :teams, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	TOPICS = "topics"
	OPINIONS = "opinions"
	OBJECTIONS = "objections"
	INITIATORS = "initiators"
	COMMENTS = "comments"
	FOLLOWING = "following"
	BOOKMARKS = "bookmarks"

	EXPANDED = "expanded"
	COLLAPSED = "collapsed"

	before_create do # Initialize the new user
		self.verbosity = 3
		self.offspring_style = COLLAPSED
		self.default_filter = TOPICS
		self.rating = 0
		self.percentile = 0

		puts "BEFORE CREATE CALLED BEFORE CREATE CALLED"

	end
end
