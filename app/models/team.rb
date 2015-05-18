class Team < ActiveRecord::Base
  has_one :topic
  has_and_belongs_to_many :provers
	
	TYPES = ["participants", "agree", "disagree", "team1", "team2"]
	
	def type= val
		if TYPES.include? val.downcase
				write_attribute(:type, val.downcase)
		else
			raise ActiveRecord::RecordInvalid.new "#{val} is not a valid team type."
		end
	end
end
