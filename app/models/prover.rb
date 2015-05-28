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
		self.filter = TOPICS
		self.rating = 0.0
		self.highest_rating = 0.0
		self.highest_rating_date = Time.now
		self.percentile = 0.0
		self.image_url = "default_avatar.png"
	end

	after_create do
		Prover.update_rankings
	end

	def calculate_rating   							# Calculate current rating for prover
		kids = Post.where("prover_id = ? AND kind = ?", self.id, Post::OPINION).order(:updated_at).limit(100)
		self.rating = 0.0
		kids.each do |k|
			self.rating += k.score.to_f
		end

		if kids.count > 0
			self.rating = self.rating / kids.count
			if self.rating > self.highest_rating
				self.highest_rating=self.rating
				self.highest_rating_date = Time.now
			end
			self.save!
		else
			0.0
		end

		return self.rating
	end

																			# Update ratings for all provers (to be called daily with cron
	def self::update_ratings() 					# immediately after "update_post_scores")
		Prover.all.each do |p|
			p.calculate_rating
		end
	end

																			# Update rankings for all provers (to be called daily with cron
	def self::update_rankings						 # immediately after "update_prover_ratings")
		i = 1
		provers = Prover.all.order(:rating).reverse_order
		provers.each do |p|
			p.ranking = i
			p.percentile = ((provers.count - i) * 100) / provers.count
			p.save!
			i += 1
		end
	end
end