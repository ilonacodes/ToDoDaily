class DashboardController < ApplicationController
  def dashboard
    tasks = Task.where('created_at >= ?', Time.zone.now.beginning_of_day)
    @time_now = Time.now.localtime.strftime('%d-%m-%Y')

    show_day(tasks)
  end

  def all_days
    date_range = 1.year.ago.to_date...Date.tomorrow.to_date

    @days = Task.where(created_at: date_range).map do |task|
      task.created_at.beginning_of_day
    end.uniq
  end

  def single_day
    day = Date.strptime(params[:day],'%d-%m-%Y')
    next_day = day + 1.day
    date_range = day...next_day

    tasks = Task.where(created_at: date_range)
    @time_now = day.strftime('%d-%m-%Y')

    show_day(tasks)

    render :template => 'dashboard/dashboard'
  end

  private

  def show_day(tasks)
    @tasks_programming = tasks.where(tag: 'Programming')
    @tasks_reading = tasks.where(tag: 'Reading')
    @tasks_sport = tasks.where(tag: 'Sport')
    @tasks_languages = tasks.where(tag: 'Languages')
    @tasks_university = tasks.where(tag: 'University')
    @tasks_daily_routine = tasks.where(tag: 'Daily Routine')

    @programming_percentage = percentage(@tasks_programming)
    @reading_percentage = percentage(@tasks_reading)
    @sport_percentage = percentage(@tasks_sport)
    @languages_percentage = percentage(@tasks_languages)
    @university_percentage = percentage(@tasks_university)
    @daily_routine_percentage = percentage(@tasks_daily_routine)
  end

  def percentage(tasks)
    return 0 if tasks.count == 0
    completed_tasks = tasks.where(completed: true).count
    ((completed_tasks.to_f / tasks.count) * 100).to_i
  end
end
