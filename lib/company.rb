# Company object from json
# containing id, name, top_up, email_status
class Company
  attr_accessor :id, :name, :top_up, :email_status, :user_emailed, :user_not_emailed

  def initialize(id, name, top_up, email_status)
    @id               = id
    @name             = name
    @top_up           = top_up
    @email_status     = email_status
    @user_emailed     = []
    @user_not_emailed = []
  end

  def add_users(users)
    users.each { |user| check_user(user) }
  end

  def get_print_string
    if (@user_emailed.length() + @user_not_emailed.length()) == 0
      return ""
    end

    str = "CompanyId: #{@id}\n"
    str += "Company Name: #{@name}\n"

    str += "User Emailed:\n"
    @user_emailed.each { |user| str+= user.get_print_string(1) }

    str += "User Not Emailed:\n"
    @user_not_emailed.each { |user| str+= user.get_print_string(1) }

    str += "  " + "Total amount of top ups for #{@name}: #{top_up * (@user_emailed.length() + @user_not_emailed.length())}\n"
    str += "\n"

    str
  end

  def total_amount_of_top_ups
    total_amount = (@user_emailed.length() + @user_not_emailed.length()) * @top_up

    total_amount
  end

  private

  def check_user(user)
    if !user.active_status
      return
    end

    if user.company_id != @id
      return
    end
    
    user.charge_tokens(@top_up)

    if user.email_status && @email_status
      @user_emailed.push(user)
    else
      @user_not_emailed.push(user)
    end
  end

end
