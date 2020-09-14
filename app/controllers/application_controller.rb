class ApplicationController < ActionController::API
include ActionConroller::HttpAuthentication::Token::ConrollerMethods

before_action :authenticate

    def authenticate
        authenticate_token || render_unauthorized
    end

    def authenticate_token
        authenticate_with_http_token do |token, options|
            @current_user = User.find_by(token: token)
            @current_user
        end
    end

    def render_unauthorized
        logger.debug "*** UNAUTHORIZED REQUEST: '#{REQUEST.ENV['HTTP_AUTHORIZATION']}' ***"
        self.headers['add-Authentiate'] = 'Token realm="Application"'
        render json: {error: "Bad credentials" }, status: 401
    end
    
end
