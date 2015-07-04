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

		if (params[:kidtype])
			@kidtype = params[:kidtype]
		else
		  @kidtype = @post.kind
		end

		@kids = Post.where(parent: @post).order(:updated_at).reverse_order	# get the featured post's kids and sort them...

		@kids.each do |p|																								# For each kid...
			p.create_team_lists																						# ...construct the team lists...
			p.create_category_lists																				# ...and category lists
		end

		# Determine if the featured post is "repliable" based on settings in the topic and post...
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
			else																													# If this post is public....
				if @post.topic.lone_wolf																		# and it's a lone wolf...
					if @post.topic.prover_id == current_prover.id							# and user is the lone wolf...
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
				if @post.team_member?(current_prover)												# and the user is a participant...
					@post.opinion_repliable = true														# he can submit an opinion...
					@post.comment_repliable = true														# or a comment.
				else																												# If he is not a participant...
					@post.opinion_repliable = false														# he can NOT submit an opinion...
					@post.comment_repliable = @post.topic.public_comments?		# but he can comment if the topic allows it.
				end
			else																													# If this topic is public...
				@post.opinion_repliable = true;															# anyone can post an opinion...
				@post.comment_repliable = true;															# or a comment.
			end
		elsif @post.kind == Post::COMMENT																# If this post is a COMMENT...
			if @post.topic.lone_wolf																			# and it's a lone wolf...
				if @post.topic.prover_id == current_prover.id								# and user is the lone wolf...
					@post.comment_repliable = @post.level.odd?								# he can only reply to odd level posts.
				else																												# If he is not the lone wolf...
					@post.comment_repliable = @post.level.even?								# he can only reply to even level posts.
				end
			else																													# If this post is NOT lone wolf...
				@post.comment_repliable = true;															# anyone can post a comment...
			end
		end

		@provers = Prover.all.order(:provername)
	end

  # GET /posts/new
  def new
		@provers = Prover.all.order(:provername)
		@categories = Category.all.order(name: :asc)
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