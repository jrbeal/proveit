class Team < ActiveRecord::Base
  belongs_to :topic
  belongs_to :prover
	
	TYPES = ["participants", "agree", "disagree", "team1", "team2"]
	
	def type= val
		if TYPES.include? val.downcase
				write_attribute(:type, val.downcase)
		else
			raise ActiveRecord::RecordInvalid.new "#{val} is not a valid team type."
		end
	end
end
