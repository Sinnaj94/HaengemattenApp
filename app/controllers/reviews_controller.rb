class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_sitesref, only: [:index, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    if params[:site].blank?
		# get all reviews and their corresponding sites and order them descending
		@reviews = Review.joins(:site).order(created_at: :desc).includes(:site)
	else
		# for filtering by site in review list
		# get all reviews which belong to site name in parameter, order them descending and also get corresponding site
		@reviews = Review.joins(:site).where( sites: { name: params[:site] }).order(created_at: :desc).includes(:site)
	end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
	@review = Review.joins(:site).includes(:site).find(params[:id])
  end

  # GET /reviews/new
  def new
    @review = Review.new
	@review.site_id = params[:site_id]
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
	@review.user_id = current_user.id
	
	# used for partials rendering in SPA
	@site = Site.find(@review.site_id)
	@sites = Site.all
	@reviews = Review.where(site_id: @site.id).order("created_at DESC")

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
	@review.user_id = current_user.id

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
	  format.js
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
	
	# load all sites that are referenced by reviews for use in filter
	def set_sitesref
      @sitesref = Site.joins(:reviews).group('name')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment, :site_id)
    end
end
