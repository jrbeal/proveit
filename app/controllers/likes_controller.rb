class LikesController < ApplicationController
	before_action :set_like, only: [:show, :edit, :update]

	# GET /likes
	# GET /likes.json
	def index
		@likes = Like.all
	end

	# GET /likes/1
	# GET /likes/1.json
	def show
	end

	# GET /likes/new
	def new
		@like = Like.new
	end

	# GET /like/1/edit
	def edit
	end

	# POST /likes
	# POST /likes.json
	def createlike
		@post = Post.find(params[:post])

		like_params = {
			:prover => Prover.find(params[:prover]),
			:post => @post,
			:likes => params[:likes],
		}

		# First look for any existing likes (or dislikes) for this post (by this user)...
		if params[:prover].present? && params[:post].present?
			@like = Like.where(:prover => params[:prover], :post => params[:post])
		end

		# If it finds any, delete them...
		@like.each do |l|
			@post = Post.find(l.post_id)
			if l.likes
				@post.update_column(:points, @post.points - 1)
			else
				@post.update_column(:points, @post.points + 1)
			end
			l.destroy
		end

		# Now create a new like with the parameters given...
		@like = Like.new(like_params)
		if @like.likes == true
			@post.update_column(:points, @post.points + 1)
		else
			@post.update_column(:points, @post.points - 1)
		end

		respond_to do |format|
			if @like.save
				format.html { render :json => @like }
				format.json { render :show, status: :created, location: @like }
			else
				format.html { render :new }
				format.json { render json: @like.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /like/1
	# PATCH/PUT /like/1.json
	def update
		respond_to do |format|
			if @like.update(like_params)
				format.html { redirect_to @like, notice: 'Like was successfully updated.' }
				format.json { render :show, status: :ok, location: @like }
			else
				format.html { render :edit }
				format.json { render json: @like.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /like/1
	# DELETE /like/1.json
	def destroylike
		if params[:prover].present? && params[:post].present?
			@like = Like.where(:prover => params[:prover], :post => params[:post])
		elsif params[:id].present?
			@like = Like.where(:id => params[:id])
		end

		@like.each do |l|
			@post = Post.find(l.post_id)
			if l.likes
				@post.update_column(:points, @post.points-1)
			else
				@post.update_column(:points, @post.points+1)
			end
			l.destroy
		end

		render :text => "Nothing"
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_like
		@like = Like.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def like_params
		params[:likes]
	end

end
