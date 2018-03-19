Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :organizations
  namespace :api do
    namespace :v1 do
      resources :evaluation_schemes
      resources :evaluation_components
      post 'grading_scales/' => 'grading_scale_and_steps#create'
      get 'grading_scales/' => 'grading_scale_and_steps#index'
      get 'grading_scales/:id' => 'grading_scale_and_steps#show'
      put 'grading_scales/:id' => 'grading_scale_and_steps#update'
      delete 'grading_scales/:id' => 'grading_scale_and_steps#destroy'
      put 'grading_scales/:id/restore' => 'grading_scale_and_steps#restore'
      post 'grading_scale_steps/' => 'grading_scale_steps#create'
      get 'grading_scale_steps/:id' => 'grading_scale_steps#show'
      put 'grading_scale_steps/:id' => 'grading_scale_steps#update'
      delete 'grading_scale_steps/:id' => 'grading_scale_steps#destroy'
      put 'grading_scale_steps/:id/restore' => 'grading_scale_steps#restore'
      put 'evaluation_schemes/:id/apply' => 'evaluation_scheme#apply'
    end
  end
end
