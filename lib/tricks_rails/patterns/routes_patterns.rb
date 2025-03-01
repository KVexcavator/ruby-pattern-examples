## 1. Namespace и Versioning (для API) 
# Используется в API-приложениях для разделения маршрутов по версиям и пространствам имён.  
# config/routes.rb 
namespace :api do
  namespace :v1 do
    resources :users, only: [:index, :show, :create]
  end
end
# Создаёт URL /api/v1/users вместо просто /users 
# В контроллере пути становятся `Api::V1::UsersController  

## 2. Constraint-based Routing (Ограничения на маршруты) 
# Позволяет ограничить маршруты в зависимости от условий (например, поддоменов или форматов).  
# config/routes.rb
constraints subdomain: 'admin' do
  namespace :admin do
    resources :dashboard, only: [:index]
  end
end
# URL admin.example.com/dashboard отправляет запрос в Admin::DashboardController#index  
# Все маршруты работают только при указанном поддомене  

# 3. Route Service Objects (Динамические маршруты через сервис) 
# Если маршруты зависят от настроек в БД, можно использовать сервис  
# app/services/dynamic_routes_loader.rb
class DynamicRoutesLoader
  def self.load_routes
    Page.where(dynamic: true).each do |page|
      Rails.application.routes.draw do
        get "/#{page.slug}", to: "pages#show", defaults: { id: page.id }
      end
    end
  end
end
# config/routes.rb
DynamicRoutesLoader.load_routes
# Загружает маршруты из базы данных (например, /about, /contact).  
# Автоматически обновляется при изменении данных.  
# использовать eсли маршруты меняются динамически (например, CMS, пользовательские страницы)

# 4. Custom Matchers (Кастомные маршруты через match)  
# Используется, если нужно обработать нестандартные HTTP-методы или параметры  
# config/routes.rb 
match "/sso/login", to: "sessions#sso_login", via: [:get, :post]
# Позволяет одному маршруту обрабатывать несколько методов (GET и POST)

# 5. Constraints by Request Type (Ограничение роутов по типу запроса) 
# Используется для API, когда разные версии поддерживаются разными клиентами.  
#config/routes.rb 
constraints(lambda { |req| req.format == :json }) do
  namespace :api do
    namespace :v2 do
      resources :users, only: [:index, :show]
    end
  end
end
# Работает только если Content-Type: application/json  


