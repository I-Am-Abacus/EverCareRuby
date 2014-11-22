require 'spec_helper'

describe "NewsItems" do
  describe "GET /news_items" do
    it "works! (now write some real specs)" do
      visit news_items_path
      response.status.should be(200)
    end
  end
end
