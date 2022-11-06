class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(8)
    if params[:sort_expired]
      @tasks = current_user.tasks.order(limit: :desc).page(params[:page])
    end
    
    if params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page])
    end

    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = current_user.tasks.title_status(title,status).page(params[:page])
      elsif title.present?
        @tasks = current_user.tasks.title(title).page(params[:page])
      elsif status.present?
        @tasks = current_user.tasks.status(status).page(params[:page])
      end
    end
  end

  def new
    @task = Task.new
  end


  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :limit, :status, :priority)
  end
end
