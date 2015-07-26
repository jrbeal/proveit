class ProversController < ApplicationController

	def show
		@prover = Prover.find(params[:id])
		@owner = @prover == current_prover
		@opinions = Post.where(:prover_id => @prover, :kind => Post::OPINION, :level => 0)
		@objections = Post.where(:prover_id => @prover, :kind => Post::OPINION, :level => 0)
		@initiators = Post.where(:prover_id => @prover, :kind => Post::INITIATOR)
		@comments = Post.where(:prover_id => @prover, :kind => Post::COMMENT)
		@follows = Follow.where(:owner => @prover)
		@followed = Follow.where(:follows => @prover)
		@bookmarks = Bookmark.where(:owner => @prover)
		@provers = Prover.all.order(:provername)
		@customfilters = Filter.where(:prover_id => current_prover, :sitedefault => false).order(name: :desc)
		@defaultfilters = Filter.where(:sitedefault => true).order(name: :desc)
		@categories = Category.all.order(name: :asc)
		@teammembership = Team.where(:prover_id => @prover)
		@teamownership = []
		@teammembership.each do |team|
			if team.topic.prover == current_prover
				@teamownership.push(team)
			end
		end
																											# We must have a fallacy folder.
		if params[:folderid]															# First see if one was passed as a parameter
			@folder = Fallacyfolder.find(params[:folderid])
		else																							# else...
			@folder = Fallacyfolder.find_by(:parent => nil)		# ...find the "root" folder.
			if @folder == nil																# If there isn't one, create one...
				Fallacyfolder.create! :name => "root", :parent => nil
				@folder = Fallacyfolder.find_by(:parent => nil)	# ...and there you go.
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

		@decay_factor = Siteconfig.find_by(:name => "decay_factor")
		@halflife = (Math.log(0.5) / Math.log(@decay_factor.floatvalue)).round
	end

	def getcurrentprover
		respond_to do |format|
			format.html { }
			format.json { render :json => {:currentprover => current_prover}.to_json }
		end
	end

	def getverbosity
		respond_to do |format|
			format.html { }
			format.json { render :json => {:verbosity => current_prover.verbosity}.to_json }
		end
	end

	def setverbosity
		verbosity = (params[:verbosity] ? params[:verbosity] : 3).to_i()
		current_prover.update(:verbosity => verbosity) if current_prover

		render :nothing => true
	end

	def setprofiletab
		tab = (params[:profiletab] ? params[:profiletab] : 'profile')
		current_prover.update(:profiletab => tab) if current_prover

		render :nothing => true
	end

	def getkidtype
		respond_to do |format|
			format.html { }
			format.json { render :json => {:kidtype => current_prover.kidtype}.to_json }
		end
	end

	def setkidtype
		kidtype = (params[:kidtype] ? params[:kidtype] : 'opinion')
		current_prover.update(:kidtype => kidtype) if current_prover

		render :nothing => true
	end

	def reset_highest_rating
		current_prover.reset_highest_rating if current_prover

		render :nothing => true
	end

	def update
		clean_params = prover_params

		if params[:prover] && params[:prover][:profile_image]
			clean_params[:image_url] = upload_image
		end

		current_prover.update clean_params

		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id
	end

	def leaderboard
		limit = params[:limit] || 20
		@top_provers = Prover.order(:rating => :desc).take(limit)
		render :leaderboard, :layout => false
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