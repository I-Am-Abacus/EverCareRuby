FactoryGirl.define do
  factory :user do
    sequence(:name)   { |n| "Person #{n}" }
    sequence(:email)  { |n| "person_#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'

    factory :user_admin do
      admin true
    end
  end

  factory :micropost do
    content 'Lorem ipsum'
    user
  end

  # factory :account do
  #   create(:user).current_account
  #   puts 'created :account'
  # end

  factory :product do
    account { create(:user).current_account }
    sequence(:name)   { |n| "Product #{n}" }

    factory :product_public do
      account { make_public_account }
    end
  end

  factory :shopping_list do
    account { create(:user).current_account }
    sequence(:name)   { |n| "Shopping list #{n}" }
    total_value { BigDecimal('0.00') }

    factory :shopping_list_expedition do
      expedition { create(:expedition) }
    end
  end

  factory :shopping_item do
    shopping_list { create(:shopping_list) }
    product { create(:product, account: shopping_list.account) }
    # user { shopping_list.account.user }
    sequence(:name)   { |n| "Shopping item #{n}" }
  end

  factory :shop do
    # shopping_list { create(:shopping_list) }
    # product { create(:product, account: shopping_list.account) }
    # user { shopping_list.account.user }
    sequence(:name)   { |n| "Shop #{n}" }
  end

  factory :expedition do
    user { create(:user) }
    shop { create(:shop) }
    # shopping_list { create(:shopping_list) }
    # product { create(:product, account: shopping_list.account) }
    # sequence(:name)   { |n| "Shop #{n}" }
  end

  factory :aisle do
    shop { create(:shop) }
    sequence(:name)   { |n| "Aisle #{n}" }

    factory :aisle_unknown do
      status { 15 }
    end
  end
end

private

def make_public_account
  account = create(:user).current_account
  account.update!(public: true)
  account
end
