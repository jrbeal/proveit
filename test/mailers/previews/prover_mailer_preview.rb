# Preview all emails at http://localhost:3000/rails/mailers/prover_mailer
class ProverMailerPreview < ActionMailer::Preview
	def sample_mail_preview
		ExampleMailer.sample_email(Prover.first)
	end
end
