Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get "/wishlist", to: "pages#list"
  get "/wishlist", to: "pages#validation", as: :validation
  get "/social", to: "pages#social"
  get "/sub", to: "pages#sub"

  get "/bookmarks/:id/add", to: "bookmarks#add", as: :add
  get "/bookmarks/:id/seen", to: "bookmarks#seen", as: :seen
  get "/bookmarks/:id/liked", to: "bookmarks#liked", as: :liked
  get "/bookmarks/:id/unliked", to: "bookmarks#unliked", as: :unliked
end
