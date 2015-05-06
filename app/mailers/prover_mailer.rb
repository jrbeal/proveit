class ProverMailer < ApplicationMailer
	default from: "jrbeal@cox.net"

	def sample_email(prover)
		@prover = prover
		mail(to: @prover.email, subject: 'Sample Email')
	end

end
