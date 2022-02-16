# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      user = User.find_or_initialize_by(email: auth.info.email.downcase)
      user.save!

      if user.persisted?
        sign_in user

        redirect_to root_path
      else
        redirect_to new_user_path
      end
    rescue ActiveRecord::RecordInvalid => e
      e.rollbar_context = { auth_hash: auth }
      raise
    end

    def destroy
      sign_out
      redirect_to root_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end

    # skip_before_action :verify_authenticity_token, only: :create

    # def create
    #   p "!!!auth_hash: #{auth_hash}"
    #   @user = User.find_or_create_from_auth_hash(auth_hash)
    #   self.current_user = @user
    #   redirect_to '/'
    # end

    # def failure
    #   p "params: #{params}"
    #   redirect_to '/'
    # end

    # protected

    # def auth_hash
    #   request.env['omniauth.auth']
    # end
  end
end
