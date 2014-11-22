class NewsItemsController < ApplicationController

  before_action :set_headers
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

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
