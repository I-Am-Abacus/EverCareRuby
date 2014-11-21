class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session     # todo:high reinstate "with: :exception". See http://stackoverflow.com/questions/16258911/rails-4-authenticity-token
  around_action :wrap_in_transaction

  include SessionsHelper
  include AccountsHelper

  def trigger_rollback_at_app_level
    @rollback_reqd = true
  end

  def rollback_triggered?
    @rollback_reqd
  end

  private

  def wrap_in_transaction
    # see http://stackoverflow.com/questions/8507596/wrap-all-controller-actions-in-transactions-in-rails
    ActiveRecord::Base.transaction do
      begin
        @rollback_reqd = false
        yield
      else      # only if no other exception (which will inc rollback) is already raised
        raise ActiveRecord::Rollback if @rollback_reqd
      # ensure    # always rolls back - copied from http://guides.rubyonrails.org/action_controller_overview.html#filters
      #   raise ActiveRecord::Rollback
      end
    end
  end
end
