Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :organizations
  namespace :api do
    namespace :v1 do
      post 'grading_scales/' => 'grading_scale_and_steps_controller#create'
      get 'grading_scales/' => 'grading_scale_and_steps_controller#index'
      get 'grading_scales/:id' => 'grading_scale_and_steps_controller#show'
      put 'grading_scales/:id' => 'grading_scale_and_steps_controller#update'
      delete 'grading_scales/:id' => 'grading_scale_and_steps_controller#destroy'
      put 'grading_scales/:id/restore' => 'grading_scale_and_steps_controller#restore'
      post 'grading_scale_steps/' => 'grading_scale_steps_controller#create'
      get 'grading_scale_steps/:id' => 'grading_scale_steps_controller#show'
      put 'grading_scale_steps/:id' => 'grading_scale_steps_controller#update'
      delete 'grading_scale_steps/:id' => 'grading_scale_steps_controller#destroy'
      put 'grading_scale_steps/:id/restore' => 'grading_scale_steps_controller#restore'
    end
  end
end
