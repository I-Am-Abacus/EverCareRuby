module SessionsHelper

  # Session variables (partial list)
  # return_to               see signed_in_user
  # shopping_list_id        whenever action is based upon a shopping list
  # exped_id                whenever action is based upon an expedition. Not to be confused with:-
  # expedition              when an expedition is being shopped. Hash of values
  # expedition / id         id of the shopped expedition
  # expedition / aisle_id   aisle currently being shopped within the expedition


  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    self.current_session = user.sessions.create!(remember_token: User.digest(remember_token))
    # user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  # @return [Object]
  def current_user=(user)
    @current_user = user
  end

  # @return [Object]
  def current_session=(session)
    @current_session = session
  end

  def current_user
    # Rails.logger.debug('current_user starts')
    # Rails.logger.debug(temp_user.inspect)
    # Rails.logger.debug(@current_user.inspect)
    # @current_user.reload unless @current_user.nil?
    # Rails.logger.debug(@current_user.inspect)
    # Rails.logger.debug('current_user ends')

    @current_user ||= current_session.try(:user)
    # @current_user ||= User.get_by_remember_token(User.digest(cookies[:remember_token]))
     # done: shouldn't use find_by in the view/helper, but can't access cookies from the model
    # @current_user ||= User.lookup_by_remember_token
  end

  def current_session
    # Rails.logger.debug('current_user starts')
    # Rails.logger.debug(temp_user.inspect)
    # Rails.logger.debug(@current_user.inspect)
    # @current_user.reload unless @current_user.nil?
    # Rails.logger.debug(@current_user.inspect)
    # Rails.logger.debug('current_user ends')

    @current_session ||= Session.get_by_remember_token(User.digest(cookies[:remember_token]))
     # done: shouldn't use find_by in the view/helper, but can't access cookies from the model
    # @current_user ||= User.lookup_by_remember_token
  end

  def current_user!
    user = current_user
    raise SecurityError, 'not logged in' unless user
    user
  end

  def current_session!
    session = current_session
    raise SecurityError, 'not logged in' unless session
    session
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

  def signed_in_admin_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
      return
    end

    unless current_user.admin?
      store_location
      redirect_to signin_url, notice: 'Please sign in as an admin user.'
    end
  end

  def sign_out
    current_session!.destroy
    # current_user!.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_session = nil
    self.current_user = nil
  end

  def sign_out_all
    current_user!.sessions.destroy_all
    # current_user!.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_session = nil
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def store_new_exped_in_session(expedition)
    session.delete(:exped_id)
    session.delete(:shopping_list_id)
    session[:expedition]          = {}
    session[:expedition][:id]     = expedition.id
    reset_expedition_expiry!
  end

  def session_exped_or_shoppinglist!
    # the session should contain either an expedition (if one applies) or a shopping_list
    # note - only used for update processes

    return @return_hash if @return_hash

    if session[:exped_id]
      expedition    = current_user!.find_expedition_for_update!(session[:exped_id])
      shopping_list = nil
      session.delete(:shopping_list_id)
    else
      raise 'Neither expedition nor shopping list specified' unless session[:shopping_list_id]
      shopping_list = current_user!.find_shoppinglist_for_update!(session[:shopping_list_id])
      if shopping_list.expedition
        expedition    = current_user!.find_expedition_for_update!(shopping_list.expedition.id)
        session[:exped_id] = expedition.id
        shopping_list      = nil
        session.delete(:shopping_list_id)
      else
        expedition = nil
        session.delete(:exped_id)
      end
    end
    @return_hash = {expedition: expedition, shopping_list: shopping_list}
  end

  def session_temp_expedition!
    session_exped_or_shoppinglist![:expedition]
  end

  def session_temp_shopping_list!
    session_exped_or_shoppinglist![:shopping_list]
  end

  def reset_expedition_expiry!
    raise 'No active expedition session' unless session[:expedition]
    reset_expedition_expiry
  end

  def reset_expedition_expiry
    session[:expedition][:expiry] = 1.hour.from_now if session[:expedition]
  end

  # def session_active_exped_status(status)
  #   if session[:exped_status_filter] == status
  #     'active'
  #   else
  #     ''
  #   end
  # end
end
