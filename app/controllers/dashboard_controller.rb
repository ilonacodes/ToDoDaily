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

    @programming_percentage = percentage(@tasks_programming)
    @reading_percentage = percentage(@tasks_reading)
    @sport_percentage = percentage(@tasks_sport)
    @languages_percentage = percentage(@tasks_languages)
    @university_percentage = percentage(@tasks_university)
    @daily_routine_percentage = percentage(@tasks_daily_routine)
  end

  def percentage(tasks)
    completed_tasks = tasks.where(completed: true).count
    ((completed_tasks.to_f / tasks.count) * 100).to_i
  end
end
