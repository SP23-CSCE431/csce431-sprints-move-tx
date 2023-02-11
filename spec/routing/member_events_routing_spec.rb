require "rails_helper"

RSpec.describe MemberEventsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/member_events").to route_to("member_events#index")
    end

    it "routes to #new" do
      expect(get: "/member_events/new").to route_to("member_events#new")
    end

    it "routes to #show" do
      expect(get: "/member_events/1").to route_to("member_events#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/member_events/1/edit").to route_to("member_events#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/member_events").to route_to("member_events#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/member_events/1").to route_to("member_events#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/member_events/1").to route_to("member_events#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/member_events/1").to route_to("member_events#destroy", id: "1")
    end
  end
end
