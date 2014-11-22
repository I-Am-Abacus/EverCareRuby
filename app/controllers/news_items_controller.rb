class NewsItemsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_hdrs

  before_action :set_news_item, only: [:show, :edit, :update, :destroy]

  # GET /news_items
  def index
    @news_items = NewsItem.all
  end

  # GET /news_items/1
  def show
  end

  # GET /news_items/new
  def new
    @news_item = NewsItem.new
  end

  # GET /news_items/1/edit
  def edit
  end

  # POST /news_items
  def create
    @news_item = NewsItem.new(news_item_params)

    if @news_item.save
      redirect_to @news_item, notice: 'News item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /news_items/1
  def update
    if @news_item.update(news_item_params)
      redirect_to @news_item, notice: 'News item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /news_items/1
  def destroy
    @news_item.destroy
    redirect_to news_items_url, notice: 'News item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def news_item_params
      params.require(:news_item).permit(:user_id, :carer_user_id, :narrative)
    end

  # def set_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  # end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method.downcase == 'options'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_hdrs
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end
