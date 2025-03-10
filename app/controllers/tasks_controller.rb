# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :load_task!, only: %i[show update destroy]

  def index
    tasks = policy_scope(Task)
    tasks_with_assigned_user = tasks.as_json(include: { assigned_user: { only: %i[name id] } })
    render_json({ tasks: tasks_with_assigned_user })
  end

  def create
    task = current_user.created_tasks.new(task_params)
    authorize task
    task.save!
    render_notice(t("successfully_created", entity: "Task"))
  end

  def show
    # render_json({ task: @task, assigned_user: @task.assigned_user })
    # render_json({ task: @task.as_json(include: { assigned_user: { only: %i[name id] } }) })
    authorize @task
    render
  end

  def update
    authorize @task
    @task.update!(task_params)
    render_notice(I18n.t("successfully_updated", entity: "Task"))
  end

  def destroy
    authorize @task
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
