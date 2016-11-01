require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'daniel', password: 'secret', password_confirmation: 'secret')
  end

  test 'user should be valid' do
    assert @user.valid?, @user.errors.full_messages
  end

  test 'username should be present' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'username should be unique' do
    @user.username = 'vasile'
    assert_not @user.valid?
  end

  test 'username should have a maximum lenght' do
    @user.username = 'a'*16
    assert_not @user.valid?
  end

  test 'username should have the right format' do
    %w[foo bar foobar foo_bar FooBar8].each do |username|
      @user.username = username
      assert @user.valid?, @user.username
    end

    %w[foo-bar foo$ *bar].each do |username|
      @user.username = username
      assert_not @user.valid?, @user.username
    end
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test 'password should have minimum length' do
    @user.password = @user.password_confirmation = 'a' *5
    assert_not @user.valid?
  end
end
