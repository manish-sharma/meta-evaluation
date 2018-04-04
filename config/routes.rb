Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :organizations
  namespace :api do
    namespace :v1 do
      resources :grading_scales do
        resources :grading_scale_steps
      end
      resources :evaluation_schemes do
        resources :evaluation_components
      end
      get 'grading_scale_steps/colors_results' => 'grading_scale_steps#colors_results'
      get 'data_for_new_es' => 'evaluation_schemes#data_for_new_es'
    end
  end
end
