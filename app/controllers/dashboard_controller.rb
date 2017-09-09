class DashboardController < ApplicationController
  def dashboard
    @tasks = Task.all

    @tasks_programming = Task.where(tag: 'Programming')
    @tasks_reading = Task.where(tag: 'Reading')
    @tasks_sport = Task.where(tag: 'Sport')
    @tasks_languages = Task.where(tag: 'Languages')
    @tasks_university = Task.where(tag: 'University')
    @tasks_daily_routine = Task.where(tag: 'Daily Routine')

    @time_now = Time.now.localtime.strftime('%d-%m-%Y')
  end
end
