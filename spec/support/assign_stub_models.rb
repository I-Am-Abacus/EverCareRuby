# include ApplicationHelper
# # require '../spec_helper'      << removed when switching rails 4.0.0 > 4.1.0

def assign_stub_user
  assign(:user, stub_model(User,
                           email: 'test@test.com',
                           name: 'user name',
                           status: 1
  ))
end

def assign_stub_account(user, name='account name')
  assign(:account, stub_model(Account,
                              id: 1,
                              user: user,
                              name: name,
                              status: 1
  ))
end

def assign_stub_product(account, name='product name', parent=nil)
  assign(:product, stub_model(Product,
                              id: 1,
                              account: account,
                              parent_product: parent,
                              name: name
  ))
end
