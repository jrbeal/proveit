class ProversController < ApplicationController
	# def new
	# end

	def show
		@default_tab = params[:default_tab] || "profile"
		@prover = Prover.find(params[:id])
		@owner = @prover == current_prover
		@opinions = Post.where("prover_id = ? AND kind = ? AND level = ?", @prover, Post::OPINION, 0)
		@objections = Post.where("prover_id = ? AND kind = ? AND level > ?", @prover, Post::OPINION, 0)
		@initiators = Post.where("prover_id = ? AND kind = ?", @prover, Post::INITIATOR)
		@comments = Post.where("prover_id = ? AND kind = ?", @prover, Post::COMMENT)
		@follows = Follow.where("owner = ?", @prover)
		@followed = Follow.where("follows = ?", @prover)
		@bookmarks = Bookmark.where("owner = ?", @prover)
		@teams = Team.where()
	end

	def update
		clean_params = prover_params

		puts params.inspect
		if params[:prover] && params[:prover][:profile_image]
			clean_params[:image_url] = upload_image
		end

		current_prover.update clean_params

		redirect_to root_path
	end

	def scoreboard
		limit = params[:limit] || 10
		@top_provers = Prover.order(:rating => :desc).take(limit)
		render :scoreboard, :layout => false
	end

	private

	def prover_params
		params.permit([:id, :first_name, :last_name, :verbosity, :location, :occupation, :education, :aboutme, :filter, :offspring_style])
	end

	def upload_image
		s3 = Aws::S3::Client.new(:region => 'us-east-1')
		id = SecureRandom::uuid

		s3.put_object(:body => params[:prover][:profile_image].open,
			:acl => "public-read",
			:bucket => "proveitimages",
			:key => id
		)

		"https://s3.amazonaws.com/proveitimages/#{id}"
	end
end