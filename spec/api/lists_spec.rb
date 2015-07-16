require "spec_helper"

describe "lists" do
  before do
    List.create(name: "First List")
    List.create(name: "Second List")
  end

  describe "GET /lists" do
    before do
      get "/lists"
    end

    it "should respond with 200" do
      expect(last_response).to be_ok
    end

    it "should return a JSON array of lists" do
      expect(json_response).to eq([{"id" => 1, "name" => "First List"}, {"id" => 2, "name" => "Second List"}])
    end
  end

  describe "POST /lists" do
    describe "with a valid request" do
      before do
        post "/lists", :list => {:name => "My Shopping List"}
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return the new list as JSON" do
        expect(json_response).to eq({"id" => 3, "name" => "My Shopping List"})
      end
    end

    describe "with invalid params" do
      before do
        post "/lists"
      end

      it "should respond with 400" do
        expect(last_response.status).to eq(400)
      end

      it "should list the error message in the response" do
        expect(json_response["error"]).to eq("name is not present")
      end
    end
  end

  describe "GET /list/:id" do
    describe "with a valid id" do
      before do
        get "/lists/1"
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return the list as JSON" do
        expect(json_response).to eq({"id" => 1, "name" => "First List"})
      end
    end

    describe "with an invalid id" do
      before do
        get "/lists/100"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "PUT /lists/:id" do
    describe "with a valid request" do
      before do
        put "/lists/1", :list => {:name => "My Shopping List"}
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return the new list as JSON" do
        expect(json_response).to eq({"id" => 1, "name" => "My Shopping List"})
      end
    end

    describe "with an invalid id" do
      before do
        put "/lists/100"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end

    describe "with invalid params" do
      before do
        put "/lists/1", :list => {:name => ""}
      end

      it "should respond with 400" do
        expect(last_response.status).to eq(400)
      end

      it "should list the error message in the response" do
        expect(json_response["error"]).to eq("name is not present")
      end
    end
  end

  describe "DELETE /list/:id" do
    describe "with a valid id" do
      before do
        delete "/lists/1"
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should delete the list" do
        expect(List[1]).to be_nil
      end
    end

    describe "with an invalid id" do
      before do
        delete "/lists/100"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end
  end
end
