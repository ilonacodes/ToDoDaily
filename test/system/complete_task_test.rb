require 'application_system_test_case'

class CompleteTaskTest < ApplicationSystemTestCase
  test 'it completes the task' do
    visit dashboard_url
    assert_selector 'h1', text: 'Dashboard'

    assert_selector('ul li')
    assert_no_selector('ul li.completed')

    first('ul li a').click

    assert_selector 'h1', text: 'Dashboard'
    assert_selector('ul li.completed')
  end
end