# User object from json
# containing id, first_name, last_name, email, company_id, email_status, active_status, tokens
class User
  attr_accessor :id, :first_name, :last_name, :email, :company_id, :email_status, :active_status, :tokens, :previous_tokens

  def initialize(id, first_name, last_name, email, company_id, email_status, active_status, tokens)
    @id               = id
    @first_name       = first_name
    @last_name        = last_name
    @email            = email
    @company_id       = company_id
    @email_status     = email_status
    @active_status    = active_status
    @tokens           = tokens
    @previous_tokens  = nil
  end

  def charge_tokens(tokens)
    @previous_tokens  = @tokens
    @tokens           = @previous_tokens + tokens
  end

  def get_print_string(tab = 0)
    str = "  " * tab
    str += "#{@last_name}, #{@first_name}, #{@email}\n"

    str += "  " * (tab + 1)
    str += "Previous Token Balance, #{@previous_tokens}\n"

    str += "  " * (tab + 1)
    str += "New Token Balance #{@tokens}\n"

    str
  end
end
