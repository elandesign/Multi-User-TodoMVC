require "spec_helper"

describe "lists" do
  before do
    List.new(name: "First List").save
    List.new(name: "Second List").save
  end

  describe "GET /lists" do
    before do
      get "/lists"
    end

    it "should respond with 200" do
      expect(last_response.status).to eq(200)
    end

    it "should return a JSON array of lists" do
      expect(json_response).to eq([{"id" => 1, "name" => "First List"}, {"id" => 2, "name" => "Second List"}])
    end
  end
end
