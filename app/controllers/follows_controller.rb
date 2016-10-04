class FollowsController < ApplicationController
	before_action :set_follow, only: [:show, :edit, :update]

	# GET /follows
	# GET /follows.json
	def index
	end

	# GET /follows/1
	# GET /follows/1.json
	def show
	end

	# GET /follows/new
	def new
	end

	# GET /follow/1/edit
	def edit
	end

	# POST /follows
	# POST /follows.json
	def create
		@owner = Prover.find(params[:owner])
		@owner.follow(Prover.find(params[:follows]))

		respond_to do |format|
			if @owner.follow(Prover.find(params[:follows]))
				format.html { render :json => {prover_id: @owner.id, following_id: params[:follows]}.to_json }
			else
				format.html { render :json => {it: "BROKE"}.to_json, :status => :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /follows/1
	# PATCH/PUT /follows/1.json
	def update
		respond_to do |format|
			if @follow.update(filter_params)
				format.html { redirect_to @follow, notice: 'Follow was successfully updated.' }
				format.json { render :show, status: :ok, location: @follow }
			else
				format.html { render :edit }
				format.json { render json: @follow.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@owner = Prover.find params[:owner]
		@owner.unfollow Prover.find params[:follows]

		render :text => "Nothing"
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_follow
		@follow = Follow.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def follow_params
		params[:follows]
	end

end
