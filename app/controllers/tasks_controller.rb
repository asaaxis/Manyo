class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(id: :desc)
    if params[:sort_expired]
      @tasks = Task.all.order(limit: :desc)
    else
      @tasks = Task.all.order(id: :desc)
    end

    if params[:task].present?
    @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%") 
    #   title = params[:task][:title]
      # status = params[:rask][:title]
      # if title.present?
      #   @tasks = Task.title(title)
      # elsif もし渡されたパラメータがタイトルのみだったとき
      # elsif もし渡されたパラメータがステータスのみだったとき
    #   end
    end
  end

  def new
    @task = Task.new
  end


  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title, :content, :limit, :status)
  end
end
