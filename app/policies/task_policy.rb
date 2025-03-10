# frozen_string_literal: true

class TaskPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def show?
    task.task_owner_id == user.id || task.assigned_user_id == user.id
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def create?
    true
  end

  def destroy?
    task.task_owner_id == user.id
  end

  def index?
    Task.where(task_owner_id: user.id).or(Task.where(assigned_user_id: user.id)).exists?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(task_owner_id: user.id).or(scope.where(assigned_user_id: user.id))
    end
  end
end
