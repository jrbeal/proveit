class Team < ActiveRecord::Base
	include ActionView::Helpers

  belongs_to :topic
  belongs_to :prover

	PARTICIPANT = "participant"
	AGREE = "agree"
	DISAGREE = "disagree"
	TEAM1 = "team 1"
	TEAM2 = "team 2"

	TYPES = [PARTICIPANT, AGREE, DISAGREE, TEAM1, TEAM2]

	# validates_inclusion_of :team_type, :in => [ TYPES ], :message => "%s is not a valid team type."

	def team_type= val
		if TYPES.include? val.downcase
				write_attribute(:team_type, val.downcase)
		else
			raise ActiveRecord::RecordInvalid.new "#{val} is not a valid team type."
		end
	end

	def topic_message
		topic.root_id.prover.provername + ": " + topic.root_id.message + " [" + self.team_type + "]"
		# topic.root_id.message
	end

	def prover_name
		prover.provername
	end

	def prover_id
		prover.id
	end
end
