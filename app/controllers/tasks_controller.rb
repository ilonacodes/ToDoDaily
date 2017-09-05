class TasksController < ApplicationController
  def create
    Task.create(title: params[:title])
    redirect_to(dashboard_url)
  end

  def complete
    task = Task.find(params[:id])
    task.completed = true
    task.save

    redirect_to(dashboard_url)
  end
end
