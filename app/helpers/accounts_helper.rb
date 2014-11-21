module AccountsHelper
  # include SessionsHelper
  # require 'sessions_helper'

  # Re-instate RSpecs if re-instating this code
  # # This looks up current_user (the currently-signed-in user).
  # # If signed-in, it tries to find an Account associated with this user, via the arguments provided.
  # def find_user_account!(search_args)
  #   raise 'no search_args specified' unless search_args
  #   user = current_user!
  #   account = user.accounts.find_by(search_args)
  #   raise SecurityError, 'account not known or not allowed for this user' unless account
  #   account
  # end

  # # This checks if the logged-in user is allowed to update the specified account (and any associated objects).
  # # This will need to be modified once multiple accounts / multiply-connected accounts are allowed.
  # def account_update_ok?(account)
  #   current_user?(account.user) ||
  #       current_user.admin
  # end

  # # This checks if the logged-in user is allowed to display the specified account (and any associated objects).
  # # This will need to be modified once multiple accounts / multiply-connected accounts are allowed.
  # def account_display_ok?(account)
  #   account_update_ok?(account) ||    # Do this first to ensure is logged in
  #       account.public
  # end
end
