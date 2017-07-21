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
  end
end
