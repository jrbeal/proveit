class SiteconfigsController < ApplicationController
	before_action :set_siteconfig, only: [:show, :edit, :update, :destroy]

	# GET /siteconfigs
	# GET /siteconfigs.json
	def index
		@siteconfigs = Siteconfig.all
	end

	# GET /siteconfigs/1
	# GET /siteconfigs/1.json
	def show
	end

	# GET /siteconfigs/new
	def new
		@siteconfig = Siteconfig.new
	end

	# GET /siteconfigs/1/edit
	def edit
	end

	# POST /siteconfigs
	# POST /siteconfigs.json
	def create
		@siteconfig = Siteconfig.new(siteconfig_params)

		respond_to do |format|
			if @siteconfig.save
				format.html { redirect_to @siteconfig, notice: 'Siteconfig was successfully created.' }
				format.json { render :show, status: :created, location: @siteconfig }
			else
				format.html { render :new }
				format.json { render json: @siteconfig.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /siteconfigs/1
	# PATCH/PUT /siteconfigs/1.json
	def update
		respond_to do |format|
			if @siteconfig.update(siteconfig_params)
				format.html { redirect_to @siteconfig, notice: 'Siteconfig was successfully updated.' }
				format.json { render :show, status: :ok, location: @siteconfig }
			else
				format.html { render :edit }
				format.json { render json: @siteconfig.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /siteconfigs/1
	# DELETE /siteconfigs/1.json
	def destroy
		@siteconfig.destroy
		respond_to do |format|
			format.html { redirect_to siteconfigs_url, notice: 'Siteconfig was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_siteconfig
		@siteconfig = Siteconfig.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def siteconfig_params
		params.require(:siteconfig).permit(:user_id, :topic_id, :siteconfig_name)
	end
end
