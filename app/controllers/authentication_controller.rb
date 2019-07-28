require 'net/http'
require 'json'

class AuthenticationController < ApplicationController

    # POST /authenticate
    def authenticate
        begin
            Net::HTTP.start(info_uri.host, info_uri.port, :use_ssl => true) do |http|
                request = Net::HTTP::Get.new info_uri
                response = http.request(request)
                user_params = user_params(response)
                user = User.find_or_create_by(uid: user_params[:uid], name: user_params[:name])
                if user.update_attributes(user_params) && user.valid? 
                    render json: { 
                        message: "Success", 
                        user: UserSerializer.new(user) ,
                        access_token: JsonWebToken.encode(id: user.id),
                        expired_time: Time.now + 72.hours.to_i
                    }, status: :ok
                else
                    render json: { message: "Failed", error: JSON.parse(response.body)['error'] }, status: :bad_request
                end
            end  
        rescue => exception
            render json: { message: "Failed", error: exception.message }, status: :bad_request
        end
    end

    def user_params(response)
        user_params = Hash.new
        response_params = JSON.parse response.body
        user_params[:uid] = response_params['id'].to_s
        user_params[:name] = response_params['name'].to_s
        user_params[:email] = response_params['email'].to_s
        user_params[:image_url] = "https://graph.facebook.com/#{response_params['id']}/picture?type=large"
        user_params[:password_digest] = 'password'
        return user_params
    end 

    def info_uri
        base_uri = 'https://graph.facebook.com/me'
        fields = 'name,email' 
        return URI("#{base_uri}?access_token=#{params[:access_token]}&fields=#{fields}")
    end

    def new
        log_out
        render 'new' 
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if (@user&.authenticate(params[:session][:password]))
            log_in @user
            if (@user.is_admin)
                redirect_to users_path
            else 
                flash.now[:danger] = 'Only admin can log into this page'
                render 'new'
            end
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
        end 
    end

    def destroy
        log_out
        redirect_to login_url 
    end
end
