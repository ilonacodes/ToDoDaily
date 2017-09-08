class TasksController < ApplicationController
  def create
    title_parts = params[:title].split('#')
    title = title_parts[0].strip
    tag = title_parts[1]
    Task.create(title: title, tag: tag)
    redirect_to(dashboard_url)
  end

  def complete
    task = Task.find(params[:id])
    task.completed = true
    task.save

    redirect_to(dashboard_url)
  end
end
