require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  routes { Api::Engine.routes }

  it 'logs in' do
    user, password = ['flop@mail.com', '123456'] 

    User.create! email: user, password: password

    User.find_by_email(user).valid_password?(password).should eq true

    post :login, params: {email: 'fre@mail.com', password: 'duck1234567'}
    response.code.should eq '401'

    post :login, params: {email: user, password: password}
    response.code.should eq '200'
    json = JSON.parse(response.body).with_indifferent_access
    data, header = JWT.decode json[:atoken], Rails.application.secrets.api_sec, true,
                      algorith: 'HS256'
    data.with_indifferent_access[:user].should eq user

    post :login, params: {login: user, password: password}
    response.code.should eq '422'
    json = JSON.parse(response.body).with_indifferent_access
    json[:error].should eq 'Parameter email is missing'
  end

  it 'shows all users' do
    1
  end
end
