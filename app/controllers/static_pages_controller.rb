class StaticPagesController < ApplicationController

  before_action :set_headers

  def home
    if signed_in?
      @status_filter = params[:status]
      @status_filter = nil unless @status_filter=='10' || @status_filter=='20' || @status_filter=='25'
    end
  end

  def admin
    raise 'Not signed in' unless signed_in?
    raise 'Not admin'     unless current_user!.admin?
    session.delete(:link)
    session.delete(:family_id)
    session.delete(:category_id)
    session.delete(:plant_id)
  end

  def help
  end

  def about
  end

  def contact
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
