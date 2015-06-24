class Filter < ActiveRecord::Base
  belongs_to :prover

	has_many :provers, :foreign_key => "cur_filter"

	# Default Filter definitions
	TOPICS = "Topics"
	OPINIONS = "Opinions"
	OBJECTIONS = "Objections"
	INITIATORS = "Initiators"
	COMMENTS = "Comments"
	FOLLOWING = "Following"
	BOOKMARKS = "Bookmarks"

	def filter_name
		self.name
	end

	def filter_id
		self.id
	end

end
