Rails.application.routes.draw do
  devise_for :users
  resources :maps
  root  'maps#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # letter_opener関連curriculums/1063
end
