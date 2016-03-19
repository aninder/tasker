class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks_today_incomplete = Task.today_incomplete_tasks
    @tasks_today_complete = Task.today_complete_tasks
    @tasks_tomorrow = Task.tomorrow_tasks
    @tasks_later = Task.later_todo_tasks
    @task = Task.new
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: 'Task was successfully created.'
    else
      @tasks_today_incomplete = Task.today_incomplete_tasks
      @tasks_today_complete = Task.today_complete_tasks
      @tasks_tomorrow = Task.tomorrow_tasks
      @tasks_later = Task.later_todo_tasks

      # =check_box("task",task.id, {checked:task.completed, class:'check', :"data-url" => "/tasks/toggle", :"data-remote"=> true, :"data-method"=> "post"})

      render :index
    end
  end

  # PATCH/PUT /tasks/1
  def update
    binding.pry
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def toggle
    @task = Task.find(params[:id].sub("task_","").to_i)
    @task.update(completed:params[:checked])

    redirect_to tasks_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :start_date, :finish_date, :completed)
    end
end