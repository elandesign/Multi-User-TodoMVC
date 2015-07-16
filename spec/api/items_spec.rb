require "spec_helper"

describe "lists" do
  before do
    list = List.create(name: "My List")
    list.add_item(name: "Do the good thing")
    list.add_item(name: "Do the bad thing", complete: true)
  end

  describe "GET /lists/:id/items" do
    describe "for a valid list" do
      before do
        get "/lists/1/items"
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return a JSON array of items" do
        expect(json_response).to eq([{"id" => 1, "list_id" => 1, "name" => "Do the good thing", "complete" => false},
                                     {"id" => 2, "list_id" => 1, "name" => "Do the bad thing", "complete" => true}])
      end
    end

    describe "for an invalid list" do
      before do
        get "/lists/100/items"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "POST /lists/:id/items" do
    describe "with a valid request" do
      before do
        post "/lists/1/items", :item => {:name => "Do the funky chicken"}
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return the new item as JSON" do
        expect(json_response).to eq({"id" => 3, "list_id" => 1, "name" => "Do the funky chicken", "complete" => false})
      end
    end

    describe "with invalid params" do
      before do
        post "/lists/1/items"
      end

      it "should respond with 400" do
        expect(last_response.status).to eq(400)
      end

      it "should list the error message in the response" do
        expect(json_response["error"]).to eq("name is not present")
      end
    end
  end

  describe "GET /list/:id/items/:id" do
    describe "with a valid id" do
      before do
        get "/lists/1/items/1"
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return the item as JSON" do
        expect(json_response).to eq({"id" => 1, "list_id" => 1, "name" => "Do the good thing", "complete" => false})
      end
    end

    describe "with an invalid id" do
      before do
        get "/lists/1/items/100"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "PUT /lists/:id/items/:id" do
    describe "with a valid request" do
      before do
        put "/lists/1/items/1", :item => {:complete => 1}
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should return the item as JSON" do
        expect(json_response).to eq({"id" => 1, "list_id" => 1, "name" => "Do the good thing", "complete" => true})
      end
    end

    describe "with an invalid id" do
      before do
        put "/lists/1/items/100"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end

    describe "with invalid params" do
      before do
        put "/lists/1/items/1", :item => {:name => ""}
      end

      it "should respond with 400" do
        expect(last_response.status).to eq(400)
      end

      it "should list the error message in the response" do
        expect(json_response["error"]).to eq("name is not present")
      end
    end
  end

  describe "DELETE /list/:id/items/:id" do
    describe "with a valid id" do
      before do
        delete "/lists/1/items/1"
      end

      it "should respond with 200" do
        expect(last_response.status).to eq(200)
      end

      it "should delete the item" do
        expect(Item[1]).to be_nil
      end
    end

    describe "with an invalid id" do
      before do
        delete "/lists/1/items/100"
      end

      it "should respond with 404" do
        expect(last_response.status).to eq(404)
      end
    end
  end
end
