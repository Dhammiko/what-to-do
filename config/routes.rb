Rails.application.routes.draw do
  root :to => "home#index"
  get "events", to: "events#index"
end
