class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :signed_out_user, only: [:new, :create,]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  before_action :not_self, only: [:destroy]
  before_action :set_headers

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      user_json = @user.as_json(root:   true,
                                except: [:password_digest, :admin, :status, :current_account_id, :created_at, :updated_at]
      )

      pretty_json = JSON.pretty_generate(user_json) # todo:later debug only

      format.json { render json: pretty_json }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)     # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to Emily\'s Edibles!'
      # redirect_to @user
      redirect_to root_path
    else
      trigger_rollback_at_app_level
      render 'new'
    end
  end

  def create_json
    dummy = user_params     # todo:high debug only
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in @user
        user_json = @user.as_json(root:   true,
                                  except: [:password_digest, :admin, :status, :current_account_id, :created_at, :updated_at]
        )

        pretty_json = JSON.pretty_generate(user_json) # todo:later debug only

        format.json { render json: pretty_json }
      else
        trigger_rollback_at_app_level
        render 'new' # todo:high how to handle / return errors??
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      trigger_rollback_at_app_level
      render 'edit'
    end
  end

  def destroy
    raise 'Please do not press this button again'
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted.'
    redirect_to users_url
  end

  def index
    raise 'Admin only' unless current_user!.admin?
    @users = User.paginate(page: params[:page])
  end

  def profile
    @user = current_user!
    json1 = @user.as_json(root: true,
                          except: [:email, :password_digest, :admin, :admin, :current_account_id, :created_at, :updated_at]
    )

    pretty_json = JSON.pretty_generate(json1)

    render json: pretty_json
  end

  def cares_for
    json1 = current_user!.cared_for_users.as_json(root: false,
                              except: [:email, :password_digest, :admin, :admin, :current_account_id, :created_at, :updated_at]
    )

    pretty_json = JSON.pretty_generate(json1)

    render json: pretty_json
  end

  def following
    id = params[:id]
    user = User.find(id)
    following_users = user.following_users.take(999)
    json1 = following_users.as_json(root: false,
                                    except: [:email, :password_digest, :admin, :admin, :current_account_id, :created_at, :updated_at]
    )

    pretty_json = JSON.pretty_generate(json1)

    render json: pretty_json
  end

  def news_feed
    id = params[:id]
    user = User.find(id)
    json1 = user.as_json(root: true,
                          include:
                                  {news_items:
                                       {
                                           except: [:updated_at]
                                       }
                                  },
                          except: [:email, :password_digest, :admin, :admin, :current_account_id, :created_at, :updated_at]
    )

    pretty_json = JSON.pretty_generate(json1)

    render json: pretty_json
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  def signed_out_user
    redirect_to(root_url) if signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user!.admin?
  end

  def not_self
    @user = User.find(params[:id])
    redirect_to(root_url) if current_user?(@user)
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
