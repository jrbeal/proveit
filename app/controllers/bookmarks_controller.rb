class BookmarksController < ApplicationController
	before_action :set_bookmark, only: [:show, :edit, :update]

	# GET /bookmarks
	# GET /bookmarks.json
	def index
		@bookmarks = Bookmark.all
	end

	# GET /bookmarks/1
	# GET /bookmarks/1.json
	def show
	end

	# GET /bookmarks/new
	def new
		@bookmark = Bookmark.new
	end

	# GET /bookmark/1/edit
	def edit
	end

	# POST /bookmarks
	# POST /bookmarks.json
	def create
		bookmark_params = {
			:owner => Prover.find(params[:owner]),
			:post => Post.find(params[:post])
		}

		@bookmark = Bookmark.new(bookmark_params)

		respond_to do |format|
			if @bookmark.save
				format.html { render :json => @bookmark }
				format.json { render :show, status: :created, location: @bookmark }
			else
				format.html { render :new }
				format.json { render json: @bookmark.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /bookmark/1
	# PATCH/PUT /bookmark/1.json
	def update
		respond_to do |format|
			if @bookmark.update(bookmark_params)
				format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
				format.json { render :show, status: :ok, location: @bookmark }
			else
				format.html { render :edit }
				format.json { render json: @bookmark.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /bookmark/1
	# DELETE /bookmark/1.json
	def destroy
		puts "Here1"
		@bookmark = Bookmark.where(:owner => params[:owner], :post => params[:post])

		@bookmark.each do |b|
			b.destroy
		end

		render :text => "Nothing"
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_bookmark
		@bookmark = Bookmark.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def bookmark_params
		params[:bookmarks]
	end

end
