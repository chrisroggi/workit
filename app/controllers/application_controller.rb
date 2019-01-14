class ApplicationController < ActionController::API

  include RequiresAuthenticationFilter

end
