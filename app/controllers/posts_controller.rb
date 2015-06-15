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

		# Update the view count...
		@post.update_column(:views, @post.views+1)

		# Create the team lists for the featured post...
		@post.create_team_lists

		if (params[:kidtype])
			@kidtype = params[:kidtype]
		else
		  @kidtype = @post.kind
		end

		# get the featured post's kids and sort them...
		# A more sophisticated sort to come...
		@kids = Post.where(:parent => @post).order(:updated_at).reverse_order

		# Not sure if this is necessary yet... I'm thinking not... Private topics are excluded from the
		# initial post list generated in the homepage view. However, it's possible to access a user's Posts
		# from their profile, some of which might be private... Might need to deal with this later...
		#
		# Now exclude the private posts...
		# @posts = []
		# @filter_results.each do |p|
		# 	if (!p.topic.private? || (p.topic.private? && (p.topic.public_viewing? || p.team_member?(current_prover))))
		# 		@posts.push(p)
		# 	end
		# end
		#

		# Determine if the featured post is "repliable" based on settings in the topic and post...
		# ... and create team lists for each post in the "kid list" (These are the little pulldown
		# menus seen in each private post)
		if @post.kind == Post::OPINION																	# If this post is an OPINION...
			if @post.topic.private																				# and the topic is private...
		 		if @post.topic.use_teams?																		# and it has teams...
					if @post.team_member?(current_prover)											# and the user is on one of these teams...
						if @post.which_team(current_prover) == Team::AGREE			# and he agrees with the OP...
							@post.opinion_repliable = @post.level.odd?						# then he can (only) reply to odd level posts.
						else																										# If the user disagrees with the OP...
							@post.opinion_repliable = @post.level.even?						# then he can (only) reply to even level posts.
						end
						@post.comment_repliable = true													# Team members can comment on any post.
					else																											# If user is not on either team...
						@post.opinion_repliable = false													# he can't reply to opinions...
						@post.comment_repliable = @post.topic.public_comments?	# but he can comment if the topic allows it.
					end
				else																												# If private topic has no teams...
					@post.opinion_repliable = true														# then any participant can submit an opinion...
					@post.comment_repliable = true														# or comment.
				end

				# Create team lists for each post...
				@kids.each do |p|
					p.create_team_lists
				end

			else																													# If this post is public....
				if @post.topic.lone_wolf																		# and it's a lone wolf...
					if @post.topic.root_id.prover_id == current_prover.id			# and user is the lone wolf...
						@post.opinion_repliable = @post.level.odd?							# he can only reply to odd level posts.
					else																											# If he is not the lone wolf...
						@post.opinion_repliable = @post.level.even?							# he can only reply to even level posts.
					end
					@post.comment_repliable = true														# Anyone can comment to a lone wolf post.
				else																												# If this post is NOT lone wolf...
					@post.opinion_repliable = true;														# anyone can post an opinion...
					@post.comment_repliable = true;														# or a comment.
				end
			end
		elsif @post.kind == Post::INITIATOR															# If this post is an INITIATOR...
			if @post.topic.private																				# and the topic is private...
				if @post.topic.use_teams?																		# and it has teams...
					if @post.team_member?(current_prover)											# and the user is on one of these teams...
						if @post.which_team(current_prover) == Team::TEAM1			# and he is on Team 1...
							@post.opinion_repliable = @post.level.odd?						# he can only reply to odd level posts.
						else																										# If he is on team 2...
							@post.opinion_repliable = @post.level.even?						# he can only reply to even level posts.
						end
						@post.comment_repliable = true													# Any team member can comment on any post.
					else																											# If user is not on either team...
						@post.opinion_repliable = false													# he can't reply to opinions...
						@post.comment_repliable = @post.topic.public_comments?	# but he can comment if the topic allows it.
					end
				else																												# If private topic has no teams...
					@post.opinion_repliable = true														# then any participant can submit an opinion...
					@post.comment_repliable = true														# or comment.
				end

				# Create team lists for each post...
				@kids.each do |p|
					p.create_team_lists
				end
			else																													# If this post is public...
				if @post.topic.lone_wolf																		# and it's a lone wolf...
					if @post.topic.root_id.prover_id == current_prover.id			# and the user is the lone wolf...
						@post.opinion_repliable = @post.level.odd?							# he can only reply to odd level posts.
					else																											# If he is NOT the lone wolf...
						@post.opinion_repliable = @post.level.even?							# he can only reply to even level posts.
					end
					@post.comment_repliable = true														# Anyone can comment to a lone wolf post.
				else																												# If the public post is NOT lone wolf...
					@post.opinion_repliable = true;														# anyone can post a reply with an opinion...
					@post.comment_repliable = true;														# or a comment.
				end
			end
		elsif @post.kind == Post::COMMENT																# If this post is a COMMENT and shows up in your queue...
			@post.opinion_repliable = true																# You can reply to it. If it's private and you can see it,
			@post.comment_repliable = true																# you are a member.

			# Create team lists for each post...
			@kids.each do |p|
				p.create_team_lists
			end
		end

		@provers = Prover.all.order(:provername)
	end

  # GET /posts/new
  def new
		@provers = Prover.all.order(:provername)
	end

    # GET /posts/1/edit
  def edit
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

    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #     format.json { render :show, status: :created, location: @post }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end

		redirect_to :controller => 'posts', :action => 'show', :id => @post.parent, :kidtype => params[:kidtype]
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