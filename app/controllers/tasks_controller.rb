class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    # ここでtaskにuser_idが入っている状態にしたい
    # user_idはcurrent_userでわかる
    # current_user.tasks.buildをするとuser_idがセットされたタスクのインスタンスができる
    # インスタンスはTask.newをしたものとcurrent_user.build.tasksを実行したものが同じもの
    # Task.newでインスタンスを作成してもuser_id自動ではセットされない

    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to @task, notice: t('.destroyed')
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content)
    end
end
