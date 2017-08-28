class DashboardController < ApplicationController
  def dashboard
    @tasks = Task.all
  end
end
