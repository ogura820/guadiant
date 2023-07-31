Rails.application.routes.draw do
  devise_for :users

  root  'maps#index'
  
  resources :maps
  resources :families
  resources :stockpiles
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # letter_opener関連curriculums/1063
end
