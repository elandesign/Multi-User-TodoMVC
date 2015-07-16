class ApplicationController < Sinatra::Base
  register Sinatra::Resources

  set :root, File.dirname(__FILE__)
  set :sprockets, Sprockets::Environment.new(root)
  set :precompile, [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
  set :assets_prefix, "/assets"
  set :digest_assets, false

  configure do
    %w{javascripts stylesheets images fonts}.each do |type|
      sprockets.append_path File.join("assets", type)
    end

    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix = assets_prefix
      config.digest = digest_assets
      config.public_path = public_folder
    end
  end

  helpers do
    include Sprockets::Helpers
  end

  get "/" do
    erb <<-END
    Hello World<br />
    <img src="<%= image_path 'under_construction.gif' %>" />
    <%= stylesheet_tag 'under_construction' %>
    END
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
