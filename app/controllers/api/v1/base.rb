require 'api/v1/documents'
require 'api/v1/infobutton_requests'

module API
  module V1
    class Base < Grape::API
      mount API::V1::Documents
      mount API::V1::InfobuttonRequests
    end
  end
end  