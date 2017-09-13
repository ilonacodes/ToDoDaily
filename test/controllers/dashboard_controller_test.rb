require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'it responds with success' do
    get dashboard_url

    assert_response :success
  end

  test 'it renders input field' do
    get dashboard_url

    assert_select 'form input[type=text][name=title]'
  end

  test 'it renders list of tasks' do
    get dashboard_url

    assert_select 'ul' do
      assert_select 'li', tasks(:one).title
      assert_select 'li', tasks(:two).title
    end
  end

  test 'it renders message if no tasks' do
    tasks(:one).destroy

    get dashboard_url

    assert_select 'ul' do
      assert_select '.no-tasks', 'Still no tasks for today'
    end
  end

  test 'it categorizes tasks by tag' do
    get dashboard_url

    assert_select 'ul.programming' do
      assert_select 'li', tasks(:one).title
      assert_select 'li', 1
    end

    assert_select 'ul.reading' do
      assert_select 'li', tasks(:two).title
      assert_select 'li', 1
    end

    assert_select 'ul.sport' do
      assert_select 'li', tasks(:three).title
      assert_select 'li', 1
    end

    assert_select 'ul.languages' do
      assert_select 'li', tasks(:four).title
      assert_select 'li', 1
    end

    assert_select 'ul.university' do
      assert_select 'li', tasks(:five).title
      assert_select 'li', 1
    end

    assert_select 'ul.daily-routine' do
      assert_select 'li', tasks(:six).title
      assert_select 'li', 1
    end
  end

  test 'it renders the completed task one' do
    tasks(:one).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:one).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:two).title
    end
  end

  test 'it renders the completed task two' do
    tasks(:two).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:two).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:one).title
    end
  end

  test 'it renders the completed task three' do
    tasks(:three).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:three).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:two).title
    end
  end

  test 'it renders the completed task four' do
    tasks(:four).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:four).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:three).title
    end
  end

  test 'it renders the completed task five' do
    tasks(:five).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:five).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:four).title
    end
  end

  test 'it renders the completed task six' do
    tasks(:six).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:six).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:five).title
    end
  end

  test 'it renders current date' do
    get dashboard_url

    time_now = Date.today
    expected = time_now.strftime('%d-%m-%Y')

    assert_select('.current-date', expected)
  end

  test 'it renders percentage of completed programming tasks' do
    Task.create(title: 'Finish tutorial', tag: 'Programming')
    tasks(:one).update(completed: true)

    get dashboard_url

    assert_select('.programming-percentage span', '50% / 100%')

  end

  test 'it renders percentage of completed reading tasks' do
    Task.create(title: 'Buy a new book', tag: 'Reading')
    tasks(:two).update(completed: true)

    get dashboard_url

    assert_select('.reading-percentage span', '50% / 100%')

  end

  test 'it renders percentage of completed sport tasks' do
    Task.create(title: 'Go to a gym', tag: 'Sport')
    tasks(:three).update(completed: true)

    get dashboard_url

    assert_select('.sport-percentage span', '50% / 100%')
  end

  test 'it renders percentage of completed languages tasks' do
    Task.create(title: 'Finish Unit 11', tag: 'Languages')
    tasks(:four).update(completed: true)

    get dashboard_url

    assert_select('.languages-percentage span', '50% / 100%')
  end

  test 'it renders percentages of completed university tasks' do
    Task.create(title: 'Do Homework', tag: 'University')
    tasks(:five).update(completed: true)

    get dashboard_url

    assert_select('.university-percentage span', '50% / 100%')
  end

  test 'it renders percentages of completed daily routine tasks' do
    Task.create(title: 'Go shopping', tag: 'Daily Routine')
    tasks(:six).update(completed: true)

    get dashboard_url

    assert_select('.daily-routine-percentage span', '50% / 100%')
  end

  test 'it can render zero tasks' do
    Task.delete_all

    get dashboard_url

    assert_select('.daily-routine-percentage span', '0% / 100%')
  end

  test 'it renders only today tasks' do
    task = Task.create(title: 'Some yesterday task', tag: 'Daily Routine', created_at: Date.yesterday)

    get dashboard_url

    tasks = assigns[:tasks_daily_routine]

    refute_includes(tasks, task)
  end

  test 'all_days renders all the days since last year' do
    Task.create(title: 'greet world', created_at: 10.days.ago)
    Task.create(title: 'greet world', created_at: 1.year.ago)
    Task.create(title: 'greet world', created_at: 370.days.ago)

    get all_days_url

    days = assigns[:days]

    [10.days.ago, 1.year.ago].each do |day|
      assert_select('.previous-day', day.strftime('%d-%m-%Y'))
    end

    assert_equal([
                   Date.today.beginning_of_day,
                   10.days.ago.beginning_of_day,
                   1.year.ago.beginning_of_day
                 ], days.to_a)
  end

  test 'it renders completed tasks for the previous day' do
    Task.create(title: 'task1', tag: 'Programming', created_at: 1.day.ago)
    Task.create(title: 'task2', tag: 'University', created_at: 1.day.ago)
    Task.create(title: 'task3', tag: 'Sport', created_at: 1.day.ago)
    Task.create(title: 'task4', tag: 'Reading', created_at: 1.day.ago)
    Task.create(title: 'task5', tag: 'Languages', created_at: 1.day.ago)
    Task.create(title: 'task6', tag: 'Daily Routine', created_at: 1.day.ago)

    yesterday = 1.day.ago.strftime('%d-%m-%Y')
    get single_day_url(yesterday)

    assert_select('ul.programming li a', text: 'task1')
    assert_select('ul.university li a', text: 'task2')
    assert_select('ul.sport li a', text: 'task3')
    assert_select('ul.reading li a', text: 'task4')
    assert_select('ul.languages li a', text: 'task5')
    assert_select('ul.daily-routine li a', text: 'task6')
  end

  test 'it renders date for yesterday' do
    yesterday = Date.yesterday.strftime('%d-%m-%Y')
    Task.create(title: 'task1', tag: 'Programming', created_at: yesterday)

    get single_day_url(yesterday)

    assert_select('.current-date', yesterday)
  end

end
