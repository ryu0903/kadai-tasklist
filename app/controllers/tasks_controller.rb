class TasksController < ApplicationController
  include SessionsHelper
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.all.page(params[:page]).per(10)
  end

  def show
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスクが追加されました。今日中にやりましょう。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの追加に失敗しました。'
      render :new
    end
  end

  def edit
    
  end

  def update
    
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    
    @task.destroy

    flash[:success] = 'タスクが削除されました。'
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_url
  end

private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def require_user_logged_in
    unless logged_in?
      flash[:danger] = 'ログインしてください。'
      redirect_to login_url
    end
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:danger] = '別のユーザーによる登録です。'
      redirect_to root_url
    end
  end  
  
end