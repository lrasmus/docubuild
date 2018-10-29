module API  
  class Base < Grape::API
    format :json

    include Grape::Jwt::Authentication
    auth :jwt
    
    mount API::V1::Base
  end
end  