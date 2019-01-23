class SitesController < ApplicationController
  load_and_authorize_resource
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
	  #@somewhere = [52.477995,13.566360]
	  #@sites = Site.within(5, :origin => @somewhere).order('distance ASC')
	  #@sites = Site.by_distance(:origin => @somewhere).order('distance ASC')
	  #bounds=Geokit::Bounds.from_point_and_radius(@somewhere,5)
    #@sites = Site.includes([:reviews,:sizes]).in_bounds(bounds)
	  #@sites.sort_by{|s| s.distance_to(@somewhere)}
	  @sites = Site.joins(:sizes).includes([:sizes, :reviews])
	  
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
	#@site = Site.joins(:reviews).includes(:reviews).find(params[:id])
    @reviews = Review.where(site_id: @site.id).order("created_at DESC")
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    @site.user_id = current_user.id

    if params[:site][:size_ids].present?
      sizesgroup = Size.find params[:site][:size_ids]
      @site.sizes = sizesgroup
    end

    respond_to do |format|
      if @site.save
        format.html { redirect_to sites_url, notice: 'Site was successfully created.' }
        format.json { render :index, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    @site.user_id = current_user.id
	if params[:site][:size_ids].present?
	  sizesgroup = Size.find params[:site][:size_ids]
	  @site.sizes = sizesgroup
	end
	
	respond_to do |format|
		# We use an atomic transaction so that we can rollback
		# the update if anything goes wrong.
		Site.transaction do
		  if @site.update(site_params)
			# Avoid passing a nil value to `attach` since it'll raise
			# a 'Blob must exist' validation error.
			if params[:site][:images]
			  # As of today, we cannot attach an
			  # associated file without saving. It'll always
			  # call `create!`. This might change soon.
			  @site.images.attach(params[:site][:images])
			end
			
			format.html { redirect_to @site, notice: 'Site was successfully updated.' }
			format.json { render :show, status: :ok, location: @site }
		  else
			format.html { render :edit }
			format.json { render json: @site.errors, status: :unprocessable_entity }
		  end
		end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
	  format.js
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.joins(:sizes).includes([:sizes, :reviews]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
	  params.require(:site).permit(:name, :description, :longitude, :latitude, :images, images_attachments_attributes: [:id, :_destroy])
    end
end
