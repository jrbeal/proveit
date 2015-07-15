class FallaciesController < ApplicationController
	before_action :set_fallacy, only: [:show, :edit, :destroy]

	# GET /fallacies
	# GET /fallacies.json
	def index
		@fallacies = Fallacy.all
	end

	# GET /fallacies/1
	# GET /fallacies/1.json
	def show
		@fallacy = Fallacy.find(params[:id])

		respond_to do |format|
			format.html { }
			format.json { render :json => {:fallacy => @fallacy}.to_json }
		end
	end

	# GET /fallacies/new
	def new
		@fallacy = Fallacy.new
	end

	# GET /fallacies/1/edit
	def edit
	end

	# POST /fallacies
	# POST /fallacies.json
	def create
		fallacy_params = {}

		if params[:name].length > 0
			case params[:type]																												# Is this a folder, or a fallacy?
				when "fallacy"
					unless Fallacy.find_by(name: params[:name], folder: params[:parent])	# Unless it already exists...
						fallacy_params[:name] = params[:name]
						fallacy_params[:folder] = Fallacyfolder.find(params[:parent])
						Fallacy.new(fallacy_params).save!																		# create accordingly
					end
				when "folder"																														# Unless it already exists...
					unless Fallacyfolder.find_by(name: params[:name], parent: params[:parent])
						fallacy_params[:name] = "#{params[:name]} --->"
						fallacy_params[:parent] = Fallacyfolder.find(params[:parent])
						Fallacyfolder.new(fallacy_params).save!															# create accordingly
					end
			end
		end

		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id, :default_tab => "administrative", :folderid => params[:parent]
	end

	# PATCH/PUT /fallacies/1
	# PATCH/PUT /fallacies/1.json
	def update
		fallacy_params = {
			:opinion => params[:message],
			:support => params[:support],
			:url => params[:url],
		}

		@fallacy = Fallacy.find(params[:fallacy_details_id])
		@fallacy.update(fallacy_params)

		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id, :default_tab => "administrative", :folderid => params[:folder]

		# respond_to do |format|
		#
		# 	if @fallacy.update(fallacy_params)
		# 		format.html { redirect_to @fallacy, notice: 'Fallacy was successfully updated.' }
		# 		format.json { render :show, status: :ok, location: @fallacy }
		# 	else
		# 		format.html { render :edit }
		# 		format.json { render json: @fallacy.errors, status: :unprocessable_entity }
		# 	end
		# end
	end

	# DELETE /fallacies/1
	# DELETE /fallacies/1.json
	def destroy
		parent = @fallacy.folder
		@fallacy.destroy

		respond_to do |format|
			format.html { }
			format.json { render :json => {:parent => parent.id}.to_json }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_fallacy
		@fallacy = Fallacy.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def fallacy_params
		params.permit(
			:name,
			:folder,
			:opinion,
			:support,
			:url)
	end
end