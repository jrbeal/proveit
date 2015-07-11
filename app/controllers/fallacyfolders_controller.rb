class FallacyfoldersController < ApplicationController
	before_action :set_fallacyfolder, only: [:show, :edit, :update, :destroy]

	# GET /fallacyfolders
	# GET /fallacyfolders.json
	def index
		@fallacyfolders = Fallacyfolder.all
	end

	# GET /fallacyfolders/1
	# GET /fallacyfolders/1.json
	def show
		@fallacyfolder = Fallacyfolder.find(params[:id])
		respond_to do |format|
			format.html { }
			format.json { render :json => @fallacyfolder.to_json }
		end
	end

	# GET /fallacyfolders/new
	def new
		@fallacyfolder = Fallacyfolder.new
	end

	# GET /fallacyfolders/1/edit
	def edit
	end

	# POST /fallacyfolders
	# POST /fallacyfolders.json
	def create
		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id, :default_tab => "administrative"
	end

	# PATCH/PUT /fallacyfolders/1
	# PATCH/PUT /fallacyfolders/1.json
	def update
		respond_to do |format|

			if @fallacyfolder.update(fallacyfolder_params)
				format.html { redirect_to @fallacyfolder, notice: 'Fallacy was successfully updated.' }
				format.json { render :show, status: :ok, location: @fallacyfolder }
			else
				format.html { render :edit }
				format.json { render json: @fallacyfolder.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /fallacyfolders/1
	# DELETE /fallacyfolders/1.json
	def destroy
		@fallacyfolder.destroy

		render :nothing => true
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_fallacyfolder
		@fallacyfolder = Fallacyfolder.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def fallacyfolder_params
		params.permit(
			:name,
			:parent)
	end
end