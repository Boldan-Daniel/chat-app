require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = users(:first).messages.build(content: 'some content')
  end

  test 'message should be valid' do
    assert @message.valid?, @message.errors.full_messages
  end


  test 'content should not be blank' do
    @message.content = ' '
    assert_not @message.valid?
  end
end
