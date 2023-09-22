require 'json'
Dir.glob('./lib/*.rb', &method(:require))

# read json files and process for homework assignment
class Runner
  
  def initialize(format=nil)
    @format     = format
  end

  def process
    users = populate_users
    companies = populate_companies
    
    output = ""
    companies.each do |company|
      company.add_users(users)
      output += company.get_print_string
    end

    print(output)
  end

  private

  def print(data)
    case @format
    when 'console'
      puts data 
    when 'txt'
      File.open('./output/output.txt', 'w'){|file|
        file.puts data
      }
      puts 'Check output.txt for new data!'
    else
      puts 'Unknown Format'
    end
  end

  def populate_users
    users = []
    file = File.read('./json/users.json')
    sorted_users = JSON.parse(file).sort_by{ |user| [user['last_name']] }
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

  def populate_companies
    companies = []
    file = File.read('./json/companies.json')
    sorted_companies = JSON.parse(file).sort_by{ |company| [company['id']] }
    sorted_companies.each do |company|
      next if !company['id']
      next if !company['top_up']

      companies.push(Company.new(
        company['id'],
        company['name'],
        company['top_up'],
        company['email_status']
      ))
    end

    companies
  end

end
