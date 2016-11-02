require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
  end

  test 'login page' do
    get login_url
    assert_response :success
  end

  test 'invalid login' do
    post login_url, params: { session: { username: @user.username, password: '' } }

    assert_response :success
    assert_template 'new'
  end

  test 'valid login and logout' do
    post login_url, params: { session: { username: @user.username, password: 'secret' } }

    assert user_logged_in?
    assert_redirected_to messages_url
    delete logout_url
    assert_not user_logged_in?
    assert_redirected_to login_url
  end

end
