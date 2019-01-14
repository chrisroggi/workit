class UsersController < ApplicationController

  requires_authentication                  only: [ :update ]

  PERMITTED_ATTRIBUTES = [ :email, :password ]

  def create
    user = User.new( user_params )

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if user.present?
      user.assign_attributes( user_params )

      if user.save
        render json: user, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :bad_request
      end
    else
      render json: { errors: [ 'User not found' ], }, status: :not_found
    end
  end

  def login
    user = User.find_by( email: params[ :email ] )

    if user.present? && user.authenticate( params[ :password ] )
      token = JsonWebToken.encode( user_id: user.id )
      render json: { token: token }, status: :ok
    else
      render json: { errors: [ 'Invalid username or password' ] }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require( :user ).permit( PERMITTED_ATTRIBUTES )
  end

end