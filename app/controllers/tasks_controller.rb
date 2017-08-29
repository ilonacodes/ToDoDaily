class TasksController < ApplicationController
  def create
    Task.create(title: params[:title])
    redirect_to '/'
  end
end
