class ProversController < ApplicationController
	# def new
	# end

	def show
		@default_tab = params[:default_tab] || "profile"
		@prover = Prover.find(params[:id])
		@owner = @prover == current_prover
		@opinions = Post.where(prover_id: @prover, kind: Post::OPINION, level: 0)
		@objections = Post.where(prover_id: @prover, kind: Post::OPINION, level: 0)
		@initiators = Post.where(prover_id: @prover, kind: Post::INITIATOR)
		@comments = Post.where(prover_id: @prover, kind: Post::COMMENT)
		@follows = Follow.where(owner: @prover)
		@followed = Follow.where(follows: @prover)
		@bookmarks = Bookmark.where(owner: @prover)
		@provers = Prover.all.order(:provername)
		@customfilters = Filter.where(prover_id: current_prover)
		@defaultfilters = Filter.where(sitedefault: true)
		@filter = Filter.new
		@teammembership = Team.where(prover_id: @prover)
		@teamownership = []
		@teammembership.each do |team|
			if team.topic.prover == current_prover
				@teamownership.push(team)
			end
		end

		length = 0
		@defaultfilters.each do |f|
			length = f.name.length if f.name.length > length
		end
		@customfilters.each do |f|
			length = f.name.length if f.name.length > length
		end

		@divider = "-" * (length * 1.5)
	end

	def reset_highest_rating
		current_prover.reset_highest_rating if current_prover
		redirect_to root_url
	end

	def update
		clean_params = prover_params

		if params[:prover] && params[:prover][:profile_image]
			clean_params[:image_url] = upload_image
		end

		current_prover.update clean_params

		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id, :default_tab => params[:default_tab]
	end

	def scoreboard
		limit = params[:limit] || 20
		@top_provers = Prover.order(:rating => :desc).take(limit)
		render :scoreboard, :layout => false
	end

	def change_filter
		current_prover.cur_filter = Filter.find params[:filter_id]
		current_prover.save!
		render :nothing => true
	end

	def toggle_offspring_setting
		current_prover.offspring_style = (current_prover.offspring_style == Prover::COLLAPSED) ? Prover::EXPANDED : Prover::COLLAPSED
		current_prover.save!
		render :nothing => true
	end

	private

	def prover_params
		params.permit([:id, :first_name, :last_name, :verbosity, :location, :occupation, :education, :aboutme, :offspring_style])
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