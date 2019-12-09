class UsersController < ApplicationController

    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_user }, only: [:show, :destroy, :update] 
    before_action -> { update_user_details_before_save }, only: [:update]

    USER_NOT_FOUND = 'No user found for id %s'.freeze

    def index
        index_model(@users)
    end

    def show
        show_model(@user,USER_NOT_FOUND % [id],:not_found)
    end

    def create
       user = User.new(first_name: first_name, last_name: last_name, email_id: email_id, password: password) 
       create_or_update_model(user)
    end

    def destroy
        destroy_model(@user,USER_NOT_FOUND % [id],:not_found)
    end 

    def update
        create_or_update_model(@user)
    end

    private

    def id
        params[:id]
    end

    def first_name
        params[:first_name]
    end

    def last_name
        params[:last_name]
    end

    def email_id
        params[:email_id]
    end

    def password
        params[:password]
    end

    def fetch_user
        @user = User.find_by(id: id)
    end

    def fetch_all
        @users = User.all
    end

    def update_user_details_before_save
        @user.first_name = first_name
        @user.last_name = last_name
        @user.email_id = email_id
        @user.password = password
    end
    
end