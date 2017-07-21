class Api::UsersController < Api::ApplicationController

  def login
    required_params(:email, :password)

    ok = User.find_by_email(params[:email]).valid_password?(params[:password]) rescue false
    if ok 
        render json: { status: "ok" }, status: 200
    else
        render json: { status: "ko" }, status: 401
    end  
  end
end