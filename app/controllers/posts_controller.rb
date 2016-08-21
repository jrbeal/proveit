class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

		@post.update_column(:views, @post.views+1)											# Update the view count...
		@post.create_team_lists																					# Create the team lists for the featured post...
		@post.create_category_lists																			# Create the category list for the featured post...

		@kids = Post.where(parent: @post).order(:updated_at).reverse_order	# get the featured post's kids and sort them...

		@kids.each do |k|																								# For each kid...
			k.create_team_lists																						# ...construct the team lists...
			k.create_category_lists																				# ...and category lists
		end

		Rails.logger.info "Here in posts #show, #{@post.kind}"

		# Determine if the featured post is "repliable" based on settings in the topic and post...
		if @post.kind == Post::OPINION																	# If this post is an OPINION...
			Rails.logger.info "We have an opinion"
			if @post.topic.private																				# and the topic is private...
		 		if @post.topic.use_teams?																		# and it has teams...
					if @post.team_member?(current_prover)											# and the user is on one of these teams...
						if @post.which_team(current_prover) == Team::AGREE			# and he agrees with the OP...
							@post.opinion_repliable = @post.level.odd?						# then he can (only) reply to odd level posts.
						else																										# If the user disagrees with the OP...
							@post.opinion_repliable = @post.level.even?						# then he can (only) reply to even level posts.
						end
						@post.comment_repliable = true													# Team members can comment on any post.
					else																											# However, if user is not on either team...
						@post.opinion_repliable = false													# he can NOT post an objection...
						@post.comment_repliable = @post.topic.public_comments?	# but he can comment if the topic allows it.
					end
				else																												# If private topic has no teams...
					if @post.team_member?(current_prover)											# and the user is a participant...
						@post.opinion_repliable = true													# then he can post an objection...
						@post.comment_repliable = true													# or a comment
					else																											# However, if he is not a participant...
						@post.opinion_repliable = false													# he can NOT post an objection...
						@post.comment_repliable = @post.topic.public_comments?	# but he can comment if the topic allows is.
					end
				end
			else																													# If this post is not private (public)....
				if @post.topic.lone_wolf																		# and it's a lone wolf...
					if @post.topic.prover_id == current_prover.id							# and the user is the lone wolf...
						@post.opinion_repliable = @post.level.odd?							# he can only reply to odd level posts.
					else																											# If he's not the lone wolf...
						@post.opinion_repliable = @post.level.even?							# he can only reply to even level posts.
					end
					@post.comment_repliable = true														# Anyone can comment to a lone wolf post.
				else																												# If this post is NOT lone wolf...
					@post.opinion_repliable = true;														# anyone can post an opinion...
					@post.comment_repliable = true;														# or a comment.
				end
			end
		elsif @post.kind == Post::INITIATOR															# If this post is an INITIATOR...
			Rails.logger.info "We have an initiator"
			if @post.topic.private																				# and the topic is private...
				if @post.team_member?(current_prover)												# and the user is a participant...
					Rails.logger.info "Setting post to be opinion and comment repliable, it's a private post but the current prover is a team member"
					@post.opinion_repliable = true														# he can submit an opinion...
					@post.comment_repliable = true														# or a comment.
				else																												# If he is not a participant...
					Rails.logger.info "Setting post to be not opinion repliable, it's a private post and the current prover is not a team member"
					@post.opinion_repliable = false														# he can NOT submit an opinion...
					@post.comment_repliable = @post.topic.public_comments?		# but he can comment if the topic allows it.
				end
			else
				Rails.logger.info "Setting post to be opinion and comment repliable, it's a public post" # If this topic is public...
				@post.opinion_repliable = true;															# anyone can post an opinion...
				@post.comment_repliable = true;															# or a comment.
			end
		elsif @post.kind == Post::COMMENT																# If this post is a COMMENT...
			Rails.logger.info "We have a comment"
			if @post.topic.lone_wolf																			# and it's a lone wolf...
				if @post.topic.prover_id == current_prover.id								# and the user is the lone wolf...
					@post.comment_repliable = @post.level.odd?								# he can only reply to odd level posts.
				else																												# If he is not the lone wolf...
					@post.comment_repliable = @post.level.even?								# he can only reply to even level posts.
				end
			else																													# If this post is NOT lone wolf...
				@post.comment_repliable = true;															# anyone can post a comment...
			end
		end

		@provers = Prover.all.order(:provername)

		@folder = Fallacyfolder.find_by(parent: nil)										# We need the "root" fallacy folder.
		if @folder == nil																								# There should already be one but if there isn't...
			Fallacyfolder.create! :name => "root", :parent => nil					# ...create one!
			@folder = Fallacyfolder.find_by(parent: nil)									# ...and there you go.
		end
		@fallacies = Fallacy.where(folder: @folder.id).order(:name)
		@subfolders = Fallacyfolder.where(parent: @folder.id).order(:name)
	end

  # GET /posts/new
  def new
		@provers = Prover.all.order(:provername)
		@categories = Category.all.order(name: :asc)
	end

    # GET /posts/1/edit
  def edit
  end

	def setdecayfactor																								# Method to set the decay factor
		weeks = (params[:weeks] ? params[:weeks] : 26).to_i()						# Use params[:weeks] else 26 if not set

		@decay_factor = Siteconfig.find_by(:name => "decay_factor")			# Calculating nth root of "weeks" by raising
		@decay_factor.update(:floatvalue => 0.5 ** (1.0 / weeks))				# 0.5 to the reciprocal of "weeks" power.

		Post::update_post_scores																				# Changing the decay factor necessitates
		Prover::update_ratings																					# a update of all post scores, user ratings
		Prover::update_rankings																					# and user rankings.

		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id
	end

	def gethalflife																										# Method to get the half life (in weeks)
		@decay_factor = Siteconfig.find_by(:name => "decay_factor")
		@halflife = (Math.log(0.5) / Math.log(@decay_factor.floatvalue)).round

		respond_to do |format|
			format.html { }
			format.json { render :json => {:halflife => @halflife}.to_json }
		end
	end

  # POST /posts
  # POST /posts.json
  def create
		post_params = {
			:message => params[:message],
			:support => params[:support],
			:kind => params[:kind],
			:url => params[:url],
		}

		@post = Post.new(post_params)

		@post.parent = Post.find params[:parentpost]
		@post.topic = Topic.find params[:topic]
		@post.prover = current_prover

		@post.save!

		redirect_to :controller => 'posts', :action => 'show', :id => @post.parent
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

	# Use callbacks to share common setup or constraints between actions.
	def set_post
		@post = Post.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def post_params
		params[:post]
	end

end