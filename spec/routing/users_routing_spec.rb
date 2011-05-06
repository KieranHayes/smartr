require "spec_helper"

describe UsersController do

  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/users" }.should route_to(:controller => "users", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/users/1" }.should route_to(:controller => "users", :action => "show", :id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/users/1" }.should route_to(:controller => "users", :action => "update", :id => "1")
    end
    
    it "recognizes and generates #reputation" do
      { :get => "/users/1/reputation" }.should route_to(:controller => "users", :action => "reputation", :id => "1")
    end
    
    it "recognizes and generates #who_is_online" do
      { :get => "/users/who_is_online" }.should route_to(:controller => "users", :action => "who_is_online")
    end
    
    it "recognizes and generates #search" do
      { :get => "/users/search" }.should route_to(:controller => "users", :action => "search")
    end
  
  end
end
