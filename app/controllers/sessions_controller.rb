class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in(user)
            flash[:notice] = 'ログインしました'
            redirect_to user_path(user.id)
            # ログイン成功した場合
        else
            flash[:danger] = 'メールアドレスまたはパスワードに誤りがあります'
            render :new
            # ログイン失敗した場合
        end
    end

    def destroy
        session.delete(:user_id)
        flash[:notice] = 'ログアウトしました'
        redirect_to new_session_path
    end
end
