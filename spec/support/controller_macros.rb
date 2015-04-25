module ControllerMacros
  def map_devise_user
    @request.env['devise.mapping'] ||= Devise.mappings[:user]
  end

  def login_user(user)
    map_devise_user
    sign_in user
  end
end
