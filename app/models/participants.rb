class Participant < ActiveRecord::Base
	belongs_to :topic
	has_many :users
	
	TEAM_TYPES = ["participant", "agree", "disagree", "team1", "team2"]
	
	def team_type= val
		if TEAM_TYPE.include? val.downcase
			write_attribute(:team_type, val.downcase)
		else
			raise ActiveRecord::RecordInvalid.new "#{val} is not a valid team type."
		end
	end
end
