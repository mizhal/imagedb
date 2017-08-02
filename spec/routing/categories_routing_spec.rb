require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing" do
    xit "routes to #index" do
      expect(:get => "/categories").to route_to("categories#index")
    end
  end
end
