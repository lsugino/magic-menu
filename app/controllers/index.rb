get '/' do
	@menu = Menu.all
  erb :index
end

post '/' do
	Menu.create(name: params[:menu_name])
	erb :index
end

get '/items' do
  erb :item_page
end

get '/menu/:id' do
  @menu = Menu.find_by_id(params[:id])
  erb :menu_page
end


# post '/menu/new' do
#   menu = Menu.create name: params[:menu_name] unless params[:menuTitle].empty?
#   return menu.name if menu
#   return 'false'
# end        


get '/item/:id' do
  @item = Item.find_by_id(params[:id]) 
  @items_menus = Item.where(item_id: params[:id])
  erb :item_page
  # at some point, only the items a user has permission to see should be shown
end

post '/item/new' do
  item = Item.create name: params[:itemTitle] unless params[:itemTitle].empty?
  unless params[:itemTitle].empty? 
          params[:menu].each do |menu_id|
    Mitem.create item_id: item.id, menu_id: menu_id.to_i unless params[:menu].empty?
          end
  end          
  return item.name if item
  return 'false'
end        
