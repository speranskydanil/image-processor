ImageProcessor::Application.routes.draw do
  scope '(:locale)' do
    devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

    resources :users, except: :create do
      collection do
        post 'create_by_admin'
      end
    end

    resources :nodes do
      member do
        get 'upload_pages'
        put 'update_pages_positions'
        put 'cancel'
        put 'duplicate'
        post 'generate_zip'
        delete 'destroy_children'
        delete 'destroy_pages'
      end
    end

    resources :pages, only: [:show, :create, :destroy] do
      member do
        get 'process_form'
        put 'process_act'
        put 'cancel'
        put 'duplicate'
        post 'insert'
      end
    end

    get 'statistics' => 'common#statistics', as: :statistics
    get 'disk_usage_for_images' => 'common#disk_usage_for_images'

    get 'new_mail_to_admin' => 'common#new_mail_to_admin', as: :new_mail_to_admin
    post 'create_mail_to_admin' => 'common#create_mail_to_admin', as: :create_mail_to_admin

    root to: 'application#root'

    get '/delayed_job' => DelayedJobWeb, anchor: false
  end
end

