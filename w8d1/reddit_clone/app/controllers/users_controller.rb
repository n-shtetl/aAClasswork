class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to subs_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      render :new
    else
      flash[:errors] = 'How did you get here?'
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
