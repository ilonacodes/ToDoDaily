require 'application_system_test_case'

class RenderCompletedTasksForThePreviousDayTest < ApplicationSystemTestCase
  test 'it renders completed tasks for the previous day' do
    yesterday = 1.day.ago

    tasks = [
      Task.create(title: 'task1', tag: 'Programming', created_at: yesterday),
      Task.create(title: 'task2', tag: 'University', created_at: yesterday),
      Task.create(title: 'task3', tag: 'Sport', created_at: yesterday)
    ]

    visit all_days_url

    click_link(yesterday.strftime('%d-%m-%Y'))

    tasks.each do |task|
      assert_selector('ul li a', text: task.title)
    end

  end
end