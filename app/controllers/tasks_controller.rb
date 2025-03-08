# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task!, only: %i[show update destroy]

  def index
    tasks = Task.all.as_json(include: { assigned_user: { only: %i[name id] } })
    render status: :ok, json: { tasks: }
  end

  def create
    task = current_user.created_tasks.new(task_params)
    task.save!
    render_notice(t("successfully_created", entity: "Task"))
  end

  def show
    # render_json({ task: @task, assigned_user: @task.assigned_user })
    # render_json({ task: @task.as_json(include: { assigned_user: { only: %i[name id] } }) })
    render
  end

  def update
    @task.update!(task_params)
    render_notice(I18n.t("successfully_updated", entity: "Task"))
  end

  def destroy
    @task.destroy!
    render_notice(I18n.t("successfully_deleted", entity: "Task"))
  end

  private

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end
end
