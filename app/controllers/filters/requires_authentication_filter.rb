module RequiresAuthenticationFilter

  class RequiresAuthentication

    def before( controller )
      user = User.find_by( id: user_id( controller.request ) )

      if user.present?
        controller.define_singleton_method( "user" ) { user }
      else
        controller.render json: { errors: 'Unauthorized' }, status: :unauthorized
      end
    end

    private

    def user_id( request )
      auth_header = request.headers[ 'Authorization' ]
      token = auth_header.split( ' ' ).last
      payload = JsonWebToken.decode( token )

      payload[ 'user_id' ]
    rescue
      nil
    end

  end

  module ClassMethods

    def requires_authentication( options = {} )
      before_action( RequiresAuthentication.new, options )
    end

  end

  def self.included( controller )
    controller.extend( ClassMethods )
  end

end