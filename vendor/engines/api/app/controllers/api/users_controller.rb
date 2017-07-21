class Api::UsersController < Api::ApplicationController

  before_action :authenticate_user!, except: :login

  def login
    required_params(:email, :password)

    ok = User.find_by_email(params[:email]).valid_password?(params[:password]) rescue false
    if ok 
        data = {user: params[:email] }  
        token = JWT.encode data, Rails.application.secrets.api_sec, 'HS256'
        render json: { atoken: token }, status: 200
    else
        render json: { error: "unknown user or password" }, status: 401
    end  
  end

  def all 
    render json: User.all.map{|u| {email: u.email} } 
  end
end