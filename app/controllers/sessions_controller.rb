class SessionsController < ApplicationController

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

    param_email = params[:email]
    if param_email
      user = User.find_by(email: param_email.downcase)
    else
      user = false
    end

    respond_to do |format|
      if user && user.authenticate(params[:password])
        sign_in user
        format.json {render json: user}
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
end
