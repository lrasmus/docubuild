module API  
  class Base < Grape::API
    format :json

    use Grape::Knock::Authenticable
    rescue_from Grape::Knock::ForbiddenError do
      error!('403 Forbidden', 403)
    end
    
    mount API::V1::Base
  end
end  