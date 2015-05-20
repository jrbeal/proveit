class ProversController < ApplicationController
	# def new
	# end

	def show
		@default_tab = params[:default_tab] || "account"
		current_prover.image_url = 'https://s3.amazonaws.com/proveitimages/jrbeal.jpg'
	end

	def update
		# s3 = Aws::S3::Client.new(:region => 'us-east-1')
		# s3 = Aws::S3::Resource.new(:region => 'us-east-1')

		current_prover.update prover_params

		# bucket = s3.bucket('prover_photos').object('photos')
		# puts bucket.inspect
		# uploaded_photo = bucket.upload_file(params[:prover][:profile_image])
		# uploaded_photo = s3.put_object(:body => params[:prover][:profile_image])

		# puts uploaded_photo.inspect

		redirect_to root_path
	end

	private

	def prover_params
		params.permit([:id, :first_name, :last_name, :verbosity, :location, :occupation, :education, :aboutme, :default_filter, :offspring_style])
	end
end