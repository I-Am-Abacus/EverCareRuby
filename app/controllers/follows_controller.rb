class FollowsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_hdrs

  before_action :signed_in_user

  # before_action :set_follow, only: [:show, :edit, :update, :destroy]

  respond_to :js
  # respond_to :html, :js

  def create
    @user = User.find(params[:follows][:cared_for_user_id])
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end


  # # GET /follows
  # def index
  #   @follows = Follow.all
  # end
  #
  # # GET /follows/1
  # def show
  # end
  #
  # # GET /follows/new
  # def new
  #   @follow = Follow.new
  # end
  #
  # # GET /follows/1/edit
  # def edit
  # end
  #
  # # PATCH/PUT /follows/1
  # def update
  #   if @follow.update(follow_params)
  #     redirect_to @follow, notice: 'Follow was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_follow
  #     @follow = Follow.find(params[:id])
  #   end
  #
  #   # Only allow a trusted parameter "white list" through.
  #   def follow_params
  #     params.require(:follow).permit(:cared_for_user_id, :following_user_id)
  #   end

  private

  # def set_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  # end

  def cors_preflight_check
    if request.method.downcase == 'options'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type, X-Prototype-Version'
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
