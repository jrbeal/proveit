class Team < ActiveRecord::Base
  belongs_to :topic
  belongs_to :prover

	PARTICIPANT = "participant"
	AGREE = "agree"
	DISAGREE = "disagree"
	TEAM1 = "team1"
	TEAM2 = "team2"

	TYPES = [PARTICIPANT, AGREE, DISAGREE, TEAM1, TEAM2]

	# validates_inclusion_of :team_type, :in => [ TYPES ], :message => "%s is not a valid team type."

	def team_type= val
		if TYPES.include? val.downcase
				write_attribute(:team_type, val.downcase)
		else
			raise ActiveRecord::RecordInvalid.new "#{val} is not a valid team type."
		end
	end

	def prover_name
		prover.provername
	end

	def prover_id
		prover.id
	end
end
