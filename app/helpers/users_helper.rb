module UsersHelper
  
  def submenu(active)
       menu = []
       menu << {:name => "Winner", :id => "winner", :link => users_path(:page => nil)}
       #menu << {:name => "Loser", :id => "loser", :link => url_for(:controller => :users, :action => :index, :page => nil)}
       menu << {:name => "Who is online?", :id => "who_is_online", :link => who_is_online_users_path}
       build_menu(menu, active)
   end
   
  def show_submenu(active)
      menu = []
      menu << {:name => "Admin", :id => "admin", :link => admin_path} unless !is_admin?
      menu << {:name => "Detail", :id => "detail", :link => user_path(:id => @user.id)}
      menu << {:name => "Edit account", :id => "edit", :link => edit_user_path(:id => @user.id)}  if current_user && current_user == @user
      menu << {:name => "Favourites", :id => "favourites", :link => user_favourites_path(:user_id => @user.id)}
      build_menu(menu, active)
  end
   
end
