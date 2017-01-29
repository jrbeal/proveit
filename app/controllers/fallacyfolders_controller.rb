class FallacyfoldersController < ApplicationController
	before_action :set_fallacyfolder, only: [:show, :edit, :update, :destroy, :contents, :search]

	# GET /fallacyfolders
	# GET /fallacyfolders.json
	def index
		@fallacyfolders = Fallacyfolder.all
	end

	# GET /fallacyfolders/1
	# GET /fallacyfolders/1.json
	def show
		respond_to do |format|
			format.html { }
			format.json { render :json => {:fallacyfolder => @fallacyfolder}.to_json }
		end
	end

	def contents
		@fallacies = Fallacy.where(folder: @fallacyfolder.id)
		@subfolders = Fallacyfolder.where(parent: @fallacyfolder.id)
		@results = @fallacies + @subfolders
		@results = @results.sort { |a, b| a.name <=> b.name }

		if (@fallacyfolder.parent)
			@parentid = @fallacyfolder.parent.id
			@parentname = @fallacyfolder.parent.name
		else
			@parentid = nil
			@parentname = ""
		end

		respond_to do |format|
			format.html { }
			format.json { render :json => {:results => @results, :parentid => @parentid, :parentname => @fallacyfolder.name}.to_json}
		end
	end

	def search
		@keyword = params[:keyword]
		@results = ""

		@fallacies = Fallacy.where(folder: @fallacyfolder.id)
		@fallacies.each do |fallacy|
			if (fallacy.name.include?(@keyword) || fallacy.opinion.include?(@keyword) || fallacy.support.include?(@keyword))
				@results = @results + fallacy
			end
		end

		@results = @results.sort { |a, b| a.name <=> b.name }

		@folder.parent ? @parentid = @folder.parent.id : @parentid = nil

		respond_to do |format|
			format.html { }
			format.json { render :json => {:results => @results, :parentid => @parentid}.to_json}
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
		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id
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
		parent = @fallacyfolder.parent
		@fallacyfolder.destroy

		respond_to do |format|
			format.html { }
			format.json { render :json => {:parent => parent.id}.to_json }
		end
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