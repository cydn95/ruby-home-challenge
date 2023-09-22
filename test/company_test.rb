require './test/test_helper'
require 'json'

def company_fixture
  company_json_string = <<-TEXT
    {
      "id": 1,
      "name": "Blue Cat Inc.",
      "top_up": 100,
      "email_status": true
    }
  TEXT

  company_obj = JSON.parse(company_json_string)

  company = Company.new(
    company_obj['id'],
    company_obj['name'],
    company_obj['top_up'],
    company_obj['email_status']
  )
end

def user_fixtures
  user_json_string = <<-TEXT
    [
      {
        "id": 25,
        "first_name": "Rachel",
        "last_name": "Graves",
        "email": "rachel.graves@fake.com",
        "company_id": 1,
        "email_status": false,
        "active_status": true,
        "tokens": 50
      },
      {
        "id": 31,
        "first_name": "Bob",
        "last_name": "Boberson",
        "email": "bob.boberson@test.com",
        "company_id": 1,
        "email_status": true,
        "active_status": true,
        "tokens": 100
      },
      {
        "id": 45,
        "first_name": "Jack",
        "last_name": "Smith",
        "email": "jack.smith@test.com",
        "company_id": 1,
        "email_status": true,
        "active_status": false,
        "tokens": 100
      },
      {
        "id": 46,
        "first_name": "John",
        "last_name": "Smith",
        "email": "john.smith@test.com",
        "company_id": 2,
        "email_status": true,
        "active_status": true,
        "tokens": 100
      }
    ]
  TEXT

  users = []
  sorted_users = JSON.parse(user_json_string).sort_by{ |user| [user['last_name']] }
  sorted_users.each do |user|
    users.push(User.new(
      user['id'],
      user['first_name'],
      user['last_name'],
      user['email'],
      user['company_id'],
      user['email_status'],
      user['active_status'],
      user['tokens'],
    ))
  end

  users
end

describe Company do
  it 'should create a company from a json object' do
   
    company = company_fixture

    assert_equal(1,                 company.id)
    assert_equal('Blue Cat Inc.',   company.name)
    assert_equal(100,               company.top_up)
    assert_equal(true,              company.email_status)
  end

  it 'should have users which belongs the company' do
    company = company_fixture
    users = user_fixtures

    company.add_users(users);

    assert_equal(1, company.user_emailed.length())
    assert_equal(1, company.user_not_emailed.length())

    assert_equal(200, company.total_amount_of_top_ups)
  end

  it 'should print company' do
    company = company_fixture
    users = user_fixtures

    company.add_users(users);

    expected = "CompanyId: 1\n"
    expected += "Company Name: Blue Cat Inc.\n"
    expected += "User Emailed:\n"
    expected += "  Boberson, Bob, bob.boberson@test.com\n"
    expected += "    Previous Token Balance, 100\n"
    expected += "    New Token Balance 200\n"
    expected += "User Not Emailed:\n"
    expected += "  Graves, Rachel, rachel.graves@fake.com\n"
    expected += "    Previous Token Balance, 50\n"
    expected += "    New Token Balance 150\n"
    expected += "  Total amount of top ups for Blue Cat Inc.: 200\n\n"

    assert_equal(expected, company.get_print_string)
  end
end
