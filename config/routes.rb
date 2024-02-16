Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "templates#index"
  post "/", to: "templates#index"

  get "/betterdoc", to: "templates#betterdoc"
  post "/betterdoc", to: "templates#betterdoc"
end
