require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
  end

  test 'index should require login' do
    get messages_url
    assert_redirected_to login_url
  end

  test 'index' do
    login_as @user

    get messages_url
    assert_response :success
  end

  test 'create should require login' do
    assert_no_difference 'Message.count' do
      post messages_url, params: { message: { content: 'some content' } }
    end

    assert_redirected_to login_url
  end

  test 'create should require content' do
    login_as @user

    assert_no_difference 'Message.count' do
      post messages_url, params: { message: { content: '' } }
    end

    assert_response :success
  end

  test 'create message' do
    login_as @user

    assert_difference 'Message.count', 1 do
      post messages_url, params: { message: { content: 'some content' } }
    end

    assert_response :success
  end

end
