require 'spec_helper'

describe "follows/edit" do
  before(:each) do
    @follow = assign(:follow, stub_model(Follow,
      :cared_for_user_id => 1,
      :following_user_id => 1
    ))
  end

  it "renders the edit follow form" do
    render

    rendered.should have_selector("form", :action => follow_path(@follow), :method => "post") do |form|
      form.should have_selector("input#follow_cared_for_user_id", :name => "follow[cared_for_user_id]")
      form.should have_selector("input#follow_following_user_id", :name => "follow[following_user_id]")
    end
  end
end
