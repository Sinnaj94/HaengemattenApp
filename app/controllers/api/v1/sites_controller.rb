class Api::V1::SitesController < Api::V1::BaseController
  load_and_authorize_resource
  before_action only: [:show, :edit, :update, :destroy]
  # todo: put into serializer
  def index
    serialized = []
    Site.all.each do |site|
      attribute = format_site(site)
      serialized.push(attribute)
    end
    render(json:serialized)
  end

  def show
    @site = Site.joins(:sizes).includes([:sizes, :reviews]).find(params[:id])
    if @site == nil
      render(json:{"error": "Key not found"})
    else
	  render(json:format_site(@site))
    end
  end

  def format_site(site)
    attribute = {
        name: site.name,
        id: site.id,
        description: site.description,
        user: {
            first: site.user.first_name,
            last: site.user.last_name,
        },
        position: {
            lon: site.longitude.to_f,
            lat: site.latitude.to_f,
        },
        belongs_to_user: site.user == current_user,
        review_count: site.reviews.size,
        comment_url: "#{api_v1_reviews_path()}?sites_id=#{site.id}",
		    meanrating: site.meanrating,
        sizes: format_sizes(site.sizes),
    }
    if site.user == current_user
      attribute.merge!(delete: site_path(site),#link_to 'delete', site, method: :delete, data: { confirm: 'Are you sure?' },
                       edit: edit_site_path(site))
    end
    attribute
  end

  def format_sizes(sizes)
    attribute = []
    sizes.all.each do |size|
      attribute.push(size.name)
    end
    attribute
  end

end