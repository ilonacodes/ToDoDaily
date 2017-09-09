require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'it responds with success' do
    get dashboard_url

    assert_response :success
  end

  test 'it loads all tasks' do
    get dashboard_url
    actual_tasks = assigns[:tasks].to_a

    expected_tasks = [tasks(:one), tasks(:two), tasks(:three), tasks(:four), tasks(:five), tasks(:six)]
    assert_equal(expected_tasks, actual_tasks)
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
end
