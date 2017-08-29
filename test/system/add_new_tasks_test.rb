require 'application_system_test_case'

class AddNewTasksTest < ApplicationSystemTestCase
  test 'it creates a new task' do
    visit dashboard_url
    assert_selector 'h1', text: 'Dashboard'

    fill_in 'title', with: 'Go shopping'
    find('input[name=title]').native.send_keys(:return)

    assert_selector 'h1', text: 'Dashboard'
    assert_selector 'ul li', text: 'Go shopping'
  end
end
