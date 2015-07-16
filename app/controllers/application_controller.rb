class ApplicationController < Sinatra::Base
  register Sinatra::Resources

  error Sequel::ValidationFailed do |ex|
    status 400
    { "error" => ex.message }.to_json
  end

  error Sequel::MassAssignmentRestriction do |ex|
    status 400
    { "error" => "invalid field(s) provided" }.to_json
  end

  error Sequel::NoMatchingRow do
    halt 404
  end

  get "/" do
    "Hello World"
  end

  resource :lists do
    get do
      List.all.map(&:to_hash).to_json
    end

    post do
      List.create(params[:list] || {}).to_json
    end

    member do
      get do |id|
        List.with_pk!(id).to_json
      end

      put do |id|
        List.with_pk!(id).set(params[:list] || {}).save.to_json
      end

      delete do |id|
        List.with_pk!(id).delete
        halt 200
      end

      resource :items do
        get do |list_id|
          List.with_pk!(list_id).items.map(&:to_hash).to_json
        end

        post do |list_id|
          List.with_pk!(list_id).add_item(params[:item] || {}).to_json
        end

        member do
          get do |list_id, id|
            Item.first!(id: id, list_id: list_id).to_json
          end

          delete do |list_id, id|
            Item.first!(id: id, list_id: list_id).delete
          end

          put do |list_id, id|
            Item.first!(id: id, list_id: list_id).set(params[:item] || {}).save.to_json
          end
        end
      end
    end
  end
end
