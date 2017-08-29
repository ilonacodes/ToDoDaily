class TasksController < ApplicationController
  def create
    Task.create(title: params[:title])
    redirect_to(dashboard_url)
  end
end
