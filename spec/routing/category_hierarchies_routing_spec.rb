require "rails_helper"

RSpec.describe CategoryHierarchiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/category_hierarchies").to route_to("category_hierarchies#index")
    end

    it "routes to #new" do
      expect(:get => "/category_hierarchies/new").to route_to("category_hierarchies#new")
    end

    it "routes to #show" do
      expect(:get => "/category_hierarchies/1").to route_to("category_hierarchies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/category_hierarchies/1/edit").to route_to("category_hierarchies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/category_hierarchies").to route_to("category_hierarchies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/category_hierarchies/1").to route_to("category_hierarchies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/category_hierarchies/1").to route_to("category_hierarchies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/category_hierarchies/1").to route_to("category_hierarchies#destroy", :id => "1")
    end

  end
end
