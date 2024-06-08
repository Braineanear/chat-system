Rails.application.routes.draw do
  resources :applications, param: :token, only: [:create, :update, :show, :index] do
    resources :chats, only: [:create, :index, :show] do
      resources :messages, only: [:create, :index, :show]
    end
  end

  get 'chats/:chat_id/messages/search', to: 'messages#search'
end
