require './test/test_helper'
require 'json'

describe User do
  json_string = <<-TEXT
    {
      "id": 25,
      "first_name": "Rachel",
      "last_name": "Graves",
      "email": "rachel.graves@fake.com",
      "company_id": 5,
      "email_status": false,
      "active_status": true,
      "tokens": 26
    }
  TEXT

  user_obj = JSON.parse(json_string)

  it 'should create a user from a json object' do
    user = User.new(
      user_obj['id'],
      user_obj['first_name'],
      user_obj['last_name'],
      user_obj['email'],
      user_obj['company_id'],
      user_obj['email_status'],
      user_obj['active_status'],
      user_obj['tokens'],
    )
    
    assert_equal(25,        user.id)
    assert_equal('Rachel',  user.first_name)
    assert_equal('Graves',  user.last_name)
  end

  it 'should charge token' do
    user = User.new(
      user_obj['id'],
      user_obj['first_name'],
      user_obj['last_name'],
      user_obj['email'],
      user_obj['company_id'],
      user_obj['email_status'],
      user_obj['active_status'],
      user_obj['tokens'],
    )

    user.charge_tokens(100)

    assert_equal(26,   user.previous_tokens)
    assert_equal(126,  user.tokens)
  end

  it 'should print user' do
    user = User.new(
      user_obj['id'],
      user_obj['first_name'],
      user_obj['last_name'],
      user_obj['email'],
      user_obj['company_id'],
      user_obj['email_status'],
      user_obj['active_status'],
      user_obj['tokens'],
    )

    user.charge_tokens(100)

    str = "#{user.last_name}, #{user.first_name}, #{user.email}\n"
    str += "  "
    str += "Previous Token Balance, #{user.previous_tokens}\n"

    str += "  "
    str += "New Token Balance #{user.tokens}\n"

    assert_equal(user.get_print_string, str)
  end

end
