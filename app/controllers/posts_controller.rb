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
		@post.update_column(:views, @post.views+1)

		if (params[:kidtype])
			@kidtype = params[:kidtype]
		else
		  @kidtype = @post.kind
		end

		cookies[:kidtype] = @kidtype

		# A more sophisticated sort to come...
		@kids = Post.where(:parent => @post).order(:updated_at).reverse_order
		@provers = Prover.all.order(:provername)
	end

  # GET /posts/new
  def new
		@provers = Prover.all.order(:provername)
#		puts @provers.inspect
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