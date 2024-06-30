class UsersController < ApplicationController
   skip_before_action :login_required, only: [:new, :create]
   
   before_action :set_user, only: [:show, :edit, :update, :destroy]
 def new
    @user = User.new
 end

 def create
   @user = User.new(user_params)
   if @user.save
      log_in(@user)
      redirect_to user_path(@user.id), notice: 'アカウントを登録しました'
     # ユーザ登録に成功した場合の処理
   else
      flash.now[:alert] = 'アカウント登録が失敗しました。'
      render :new
     # ユーザ登録に失敗した場合の処理:render new で登録画面再掲
   end
 end

 def show
   @user = User.find(params[:id])
 end

 def edit
 end

 def update
   if @user.update(user_params)
     redirect_to @user, notice: 'アカウントを更新しました'
   else
     render :edit
   end
 end

 def destroy
   @user.destroy
   redirect_to tasks_path, notice: 'アカウントが削除されました。'
 end

 private

 def set_user
   @user = User.find(params[:id])
 end
 
 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end

end
