class SessionsController < ApplicationController
    before_action :authorize

    def create
        user = User.find_by(username: params[:username])
        session[:user_id] = user.id
       if user.valid?
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end

      end

      def destroy
        session.delete :user_id
        head :no_content
      end

      def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
      end

end
