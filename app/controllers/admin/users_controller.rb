class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.select(:id, :name, :email, :admin)
  end

  def show
    @tasks = @user.tasks.all
    @tasks = @tasks.page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー登録しました." 
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました." 
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました." 
    else
      redirect_to admin_users_path, notice: "管理者がいなくなるので削除できません." 
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def if_not_admin
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
