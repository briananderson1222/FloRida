require 'rest_client'

 module Service

   # Makes a HTTP request a returns a response
   #
   # @param url [String] the absolute URL for the request
   # @param request_method [String] the request method. Currently supports [GET, POST, PUT, DELETE]
   # @param query_params [Hash] the query_params for the request
   # @param send_headers [Hash] the headers for the request
   # @param request_body [String] the request_body
   # @return [Object] a request object
   def http_request(url, request_method, query_params = { }, send_headers = { }, request_body = '')
     if !request_body
       request_body = ''
     end
     if !send_headers
       send_headers = { }
     end
     if query_params && !query_params.empty?
      send_headers[:params] = query_params
     end
     begin
       if request_method.to_s.upcase == 'GET'
         RestClient.get url, send_headers
       elsif request_method.to_s.upcase == 'POST'
         RestClient.post url, request_body, send_headers
       elsif request_method.to_s.upcase == 'PUT'
         RestClient.put url, request_body, send_headers
       elsif request_method.to_s.upcase == 'DELETE'
         RestClient.delete url, send_headers
       elsif request_method.to_s.upcase == 'OPTIONS'
         RestClient.options url, send_headers
       else
         nil
       end
     rescue => e

       e.response
     end
   end

  end
