class UsersController < ApplicationController
    before_action :logged_admin_user
    def index 
        @users = User.all
    end
end
