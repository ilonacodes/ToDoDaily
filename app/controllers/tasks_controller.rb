class TasksController < ApplicationController
  def create
    @task = Task.create(title: params[:title])
    redirect_to '/'
  end
end
