class Filter < ActiveRecord::Base
	belongs_to :owner, :class_name => "Prover", :foreign_key => "prover_id"
	belongs_to :who, :class_name => "Prover", :foreign_key => "who_id"
	has_many :provers, :foreign_key => "cur_filter"
	has_and_belongs_to_many :categories, :dependent => :destroy
	validates_uniqueness_of :name

	DEFAULT = "Topics"

	def filter_name
		self.name
	end

	def filter_id
		self.id
	end

end
