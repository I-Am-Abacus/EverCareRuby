class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_hdrs

  # respond_to :html, :js

def new
  end

  def create
    if signed_in?
      sign_out
    end

    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      flash[:success] = 'Welcome back to Emily\'s Edibles!'
      redirect_back_or root_path
      # redirect_back_or user
    else
      trigger_rollback_at_app_level
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def create_json
    if signed_in?
      sign_out
    end

    param_email    = params[:email]
    param_password = params[:password]
    if param_email && param_password
      user = User.find_by(email: param_email.downcase)
    else
      user = false
    end

    respond_to do |format|
      if user && user.authenticate(param_password)
        sign_in user
        user_json = user.as_json(root: true,
                                 except: [:password_digest, :admin, :status, :current_account_id, :created_at, :updated_at]
        )

        pretty_json = JSON.pretty_generate(user_json)

        format.json { render json: pretty_json }      # todo:later debug only
      else
        trigger_rollback_at_app_level
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def destroy_all
    signed_in_user

    user = current_user!
    sign_out_all
    sign_in(user)
    redirect_to root_url
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
