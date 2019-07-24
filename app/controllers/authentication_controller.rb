require 'net/http'

require 'json'

class AuthenticationController < ApplicationController

    # POST /authenticate
    def authenticate
        begin
            Net::HTTP.start(info_uri.host, info_uri.port, :use_ssl => true) do |http|
                request = Net::HTTP::Get.new info_uri
                response = http.request(request)
                user_params = JSON.parse response.body
                user = User.find_or_create_by(name: user_params['name'], email: user_params['email'], uid: user_params['id'])
                if user.valid? 
                    render json: { message: "Success", user: user }, status: response.code
                else
                    render json: { message: "Failed", error: JSON.parse(response.body)['error'] }, status: :bad_request
                end
            end  
        rescue => exception
            render json: { message: "Failed", error: exception.message }, status: :bad_request
        end
    end

    def info_uri
        base_uri = 'https://graph.facebook.com/me'
        fields = 'name,email' 
        return URI("#{base_uri}?access_token=#{params[:access_token]}&fields=#{fields}")
    end

    def new
        render 'new' 
    end
end
