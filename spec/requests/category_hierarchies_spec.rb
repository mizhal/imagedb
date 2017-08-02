require 'rails_helper'

RSpec.describe "CategoryHierarchies", type: :request do
  describe "GET /category_hierarchies" do
    it "works! (now write some real specs)" do
      get category_hierarchies_path
      expect(response).to have_http_status(200)
    end
  end
end
