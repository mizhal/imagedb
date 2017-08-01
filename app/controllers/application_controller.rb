class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from 'AuthorizationError' do |exception| 
    redirect_to root_url, flash: { danger: I18n.t('unauthorized') } 
  end

  def require_roles(*required_roles)
    current_roles = current_user.roles.collect(&:slug).collect(&:to_sym)
    raise AuthorizationError, 'role required' unless (required_roles - current_roles).empty?
  end
end
