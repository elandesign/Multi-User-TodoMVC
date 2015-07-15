class ApplicationController < Sinatra::Base
  register Sinatra::Resources

  get "/" do
    "Hello World"
  end

  resource :lists do
    get do
      List.all.map(&:values).to_json
    end

    post do
      list = List.new(params[:list]).save
      list.values.to_json
    end

    member do
      get do |id|
        List[id].values.to_json
      end

      delete do |id|
        List[id].delete
      end

      resource :items do
        get do |list_id|
          List[list_id].items.map(&:values).to_json
        end

        post do |list_id|
          item = List[list_id].add_item(params[:item])
          item.values.to_json
        end

        member do
          get do |list_id, id|
            List[list_id].items(id: id).first.values.to_json
          end

          delete do |id|
            List[list_id].items(id: id).first.delete
          end
        end
      end
    end
  end
end
