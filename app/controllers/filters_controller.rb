class FiltersController < ApplicationController
  before_action :set_filter, only: [:show, :edit, :update, :destroy]

  # GET /filters
  # GET /filters.json
  def index
    @filters = Filter.all
  end

  # GET /filters/1
  # GET /filters/1.json
  def show
		@filter = Filter.find(params[:id])
		respond_to do |format|
			format.html { }
			format.json { render :json => @filter.to_json }
		end
  end

  # GET /filters/new
  def new
    @filter = Filter.new
  end

  # GET /filters/1/edit
  def edit
  end

  # POST /filters
  # POST /filters.json
  def create
		filter_params = {}
		filter_params[:prover_id] = current_prover.id
		filter_params[:sitedefault] = params[:sitedefault] == "true"
		filter_params[:opinions] = params[:opinions] == "true"
		filter_params[:initiators] = params[:initiators] == "true"
		filter_params[:comments] = params[:comments] == "true"
		filter_params[:bookmarks] = params[:bookmarks] == "true"
		filter_params[:lone_wolf] = params[:lone_wolf] == "true"
		filter_params[:following] = params[:following] == "true"
		filter_params[:private] = params[:privateposts] == "true"
		filter_params[:public_viewing] = params[:public_viewing] == "true"
		filter_params[:public_comments] = params[:public_comments] == "true"
		filter_params[:contested] = params[:status] == "contested"
		filter_params[:uncontested] = params[:status] == "uncontested"
		filter_params[:has_parent] = params[:parents] == "has_parent"
		filter_params[:has_no_parent] = params[:parents] == "has_no_parent"
		filter_params[:level_zero] = params[:level] == "zero"
		filter_params[:level_nonzero] = params[:level] == "nonzero"
		filter_params[:today] = params[:timerange] == "today"
		filter_params[:last_week] = params[:timerange] == "last_week"
		filter_params[:last_month] = params[:timerange] == "last_month"
		filter_params[:last_year] = params[:timerange] == "last_year"
		filter_params[:sort_by_created_at] = params[:sort] == "sort_by_created_at"
		filter_params[:sort_by_updated_at] = params[:sort] == "sort_by_updated_at"
		filter_params[:sort_by_views] = params[:sort] == "sort_by_views"
		filter_params[:sort_by_votes] = params[:sort] == "sort_by_votes"
		filter_params[:who_id] = params[:filter_users_dropdown] if params[:filter_users_dropdown] != "-1"

		if params[:myfiltername].length > 0
			filter = Filter.find_by id: current_prover.id, name: params[:myfiltername]
			filter_params[:name] = params[:myfiltername]
			if filter
				filter.update(filter_params)
			else
				Filter.new(filter_params).save!
			end
		end

		redirect_to :controller => 'provers', :action => 'show', :id => current_prover.id, :default_tab => "filters"
	end

  # PATCH/PUT /filters/1
  # PATCH/PUT /filters/1.json
  def update
		respond_to do |format|

      if @filter.update(filter_params)
        format.html { redirect_to @filter, notice: 'Filter was successfully updated.' }
        format.json { render :show, status: :ok, location: @filter }
      else
        format.html { render :edit }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filters/1
  # DELETE /filters/1.json
  def destroy
		@filter.destroy

		render :nothing => true
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filter
      @filter = Filter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filter_params
      params.permit(
				:name,
				:sitedefault,
				:opinions,
				:contested,
				:uncontested,
				:initiators,
				:comments,
				:following,
				:bookmarks,
				:lone_wolf,
				:level_zero,
				:level_nonzero,
				:private,
				:public_viewing,
				:public_comments,
				:has_parent,
				:has_no_parent,
				:today,
				:last_week,
				:last_month,
				:last_year,
				:sort_by_created_at,
				:sort_by_updated_at,
				:sort_by_views,
				:sort_by_votes,
				:who_id)
    end
end
