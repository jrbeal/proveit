class Prover < ActiveRecord::Base
	belongs_to :cur_filter, :class_name => "Filter", :foreign_key => "cur_filter"
	has_many :teams, :dependent => :destroy
	has_many :bookmarks, :foreign_key => "owner", :dependent => :destroy
	has_many :posts, :dependent => :destroy
	has_many :filters, :foreign_key => "who_id", :dependent => :destroy
	has_many :filters, :dependent => :destroy
	has_many :topics, :dependent => :destroy
	has_many :likes, :dependent => :destroy
	has_many :groups, :foreign_key => "owner", :dependent => :destroy

	has_and_belongs_to_many :followers,
		:class_name => "Prover",
		:join_table => "followings",
		:foreign_key => "prover_id",
		:association_foreign_key => "following_id",
		:dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	EXPANDED = "expanded"
	COLLAPSED = "collapsed"

	before_create do # Initialize the new user
		self.verbosity = 3
		self.profiletab = 'profile'
		self.kidtype = 'opinion'
		self.offspring_style = COLLAPSED
		self.cur_filter = Filter.where(sitedefault: true, name: Filter::DEFAULT).first
		self.rating = 0.0
		self.highest_rating = 0.0
		self.highest_rating_date = Time.now
		self.percentile = 0.0
		self.image_url = 'default_avatar.png'
	end

	after_create do
		Prover.update_rankings
	end

	def followees
		Prover.where("id in
 (select prover_id from followings where following_id = ?)", id)
	end

	def calculate_rating   							# Calculate current rating for prover
		posts = Post.where("prover_id = ? AND kind = ?", self.id, Post::OPINION).order(:updated_at).limit(100)
		self.rating = 0.0
		posts.each do |p|
			self.rating += p.score.to_f
		end

		if posts.count > 0
			self.rating = self.rating / posts.count
			if self.rating > self.highest_rating
				self.highest_rating=self.rating
				self.highest_rating_date = Time.now
			end
		end

		self.save!
		return self.rating
	end

	def reset_highest_rating
		self.highest_rating=self.rating
		self.highest_rating_date = Time.now
		self.save!
	end

																			# Update ratings for all provers (to be called periodically with cron
	def self::update_ratings() 					# immediately after "update_post_scores")
		Prover.all.each do |p|
			p.calculate_rating
		end
	end

																			# Update rankings for all provers (to be called periodically with cron
	def self::update_rankings					  # immediately after "update_prover_ratings")
		provers = Prover.all.order(:rating).reverse_order
		provers.each_with_index do |p,i|
			p.ranking = i + 1
			p.percentile = ((provers.count - (i + 1)) * 100) / provers.count
			p.save!
		end
	end

	def follow(prover)
		prover.followers << self unless follows?(prover) || prover.id == id
		prover.save
	end

	def follows?(prover)
		prover.followers.include? self
	end

	def unfollow(prover)
		prover.followers.delete self
	end
end