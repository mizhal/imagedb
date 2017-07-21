module Api
  class ApplicationController < ActionController::API

    rescue_from 'Api::ParamMissing' do |exception|
      render json: {error: exception.message}, status: 422
    end

    protected 

    def required_params *r_par 
      r_par.each do |par|
        raise Api::ParamMissing.new(par) unless params.has_key?(par)
      end
    end

    Warden::Strategies.add :atoken_auth do
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        kind, token = request.headers['Authorization'].split(" ") 
        data = JWT.decode token, Rails.application.secrets.api_sec, true, 
                          algorith: 'HS256'
        data[:claims] 
        success! user, "success"
      end
    end

  end
end
