$prompt = TTY::Prompt.new


def help
  help = <<-HELP
  What Each Command Option Means:
  -- help : displays this help message
  -- view list : displays your current quote list
  -- search : displays search options
  -- topic : searches by inputed topic
     When 'topic' is inputed, you can search by
      * funny
      * motivational
      * depressing
      * friendship
      * love
  -- length : searches by inputed length
      When 'length' is inputed, you can search by
      * short
      * medium
      * long
  -- author : searches by inputed author
     Current authors available
     * Abraham Lincoln
     * Lil Uzi Vert
     * Helen Keller
     * Marilyn Monroe
     * Chance the Rapper
  -- add to list : asks you which quote you want to add by list number
     * adds your quote to your list
     * only available while in 'search'
  -- delete : asks you which quote you want to delete from your list by list number
     * deletes quote from list
     * only available while in 'view list'
  -- go back : returns home
  -- log_out : logs you out of your session
  HELP
  puts help
end

def screen1
  puts ""
  @screen1 = [
    {"Login" => -> do login end},
    {"Register" => -> do register end}
  ]
  $prompt.select("Disquote: Helping you find this quote!\n", @screen1)
end

 def register
   @fullname = $prompt.ask("Please enter your full name:") do |q|
     q.required true
   end

   @email = $prompt.ask("Please enter your email address:") do |q|
     q.required true
     q.validate /\A\w+@\w+\.\w+\Z/
     q.messages[:valid?] = "Invalid email! c'mon guy.."
   end

   @username = $prompt.ask("Please enter your username:") do |q|
     q.required true
     q.validate /^[0-9a-zA-Z]{6,}*$/
     q.messages[:valid?] = 'Invalid username! Username must only contain A-Z or 0-9, and must be at least 6 characters long'
   end

   lock = $prompt.decorate('🔒')
   @password = $prompt.mask("Please enter your password:", mask:lock) do |p|
     p.required true
     p.validate /^[0-9a-zA-Z]{8,}*$/
     p.messages[:valid?] = "Invalid password! Password must only contain A-Z or 0-9, and must be at least 8 characters long"
   end

   @user = User.create(username: @username)

 end

def usernames
  #helper method to recieve list of all user names
  @saved_name = User.all.map {|user| user.username}
end

def login
  usernames
  #asking username
  @username = $prompt.ask("Please enter your username:") do |q|
    q.required true
    q.validate /^[0-9a-zA-Z]{6,}*$/
    q.messages[:valid?] = 'Invalid username! Username must only contain A-Z or 0-9, and must be at least 6 characters long'
  end
  #checking if user exists
  if @saved_name.include?(@username)
    @user =  User.all.find_by username: @username
  else
    puts "Error! No user by that name. Please Register: "
    register
  end
  #asking for password
  lock = $prompt.decorate('🔒')
  @password = $prompt.mask("Please enter your password:", mask:lock) do |p|
    p.required true
    p.validate /^[0-9a-zA-Z]{8,}*$/
    p.messages[:valid?] = "Invalid password! Password must only contain A-Z or 0-9, and must be at least 8 characters long"
  end
#binding.pry
end

def home
  @home = [
    {"Help" => -> do help end},
    {"View List" => -> do view_list end},
    {"Search" => -> do search end},
    {"Log Out" => -> do exit end},
  ]
  $prompt.select("---------------------------Main Menu--------------------------\n", @home)
end

def go_back(string="")
  @go_back = [{"Go Back" => -> do home end}]
    #binding.pry
  $prompt.select(string, @go_back)
end

def add_to_list(string="")
  @add_to_list = [{"Add to List" => -> do search end}]
    $prompt.select(string, @add_to_list)
end

def delete(string="")
  @delete_from_list = [{"Delete from List" => -> do delete end}]
    $prompt.select(string,@delete_from_list)

end

def individual_quotes
  Favorite.all.select do |favorite|
    @user.id == favorite.user_id

#binding.pry
    favorite.quote
  end
end

def view_list
  individual_quotes
  #binding.pry
  if @username == User.last.username
    go_back("You don't have any quotes yet. Search for some quotes to add!")
  else
    puts "Your Favorite Quotes: "
    puts  @user.quote_strings

    # go_back
    # add_to_list
    # delete
    @view_list = [
      {"Go Back" => -> do home end},
      {"Add to List" => -> do search end},
      {"Delete from List" => -> do delete end}
   ]
   $prompt.select("",@view_list)
  end
end


def search
  puts "Would you like to search by category or all"
  @search_options = [
    {"Categories" => -> do search_by_category end},
    {"All" => -> do search_all end}
  ]

  $prompt.select("", @search_options)

end

def search_by_category
@selection =  $prompt.select("Choose your category?", %w(funny motivational love friendship depressing))
#binding.pry
  if @selection == "motivational"
    motivational_quotes
  end
end
  def motivational_quotes
    @choices = [
      {"There's enough money for everybody. See, I can't do what Yachty does. But then again, Yachty can't do what I do." => -> do view_list end},
    {"Fear is stupid. So are regrets" => -> do view_list end},
    {"I'm a good man, and I'm gonna become a better man" => -> do view_list end}

    ]
    choice_result = $prompt.select("Which quote would you like to add?", @choices)

binding.pry
end


  #binding.pry
#   song1 = Quote.all[0].quote
#   choices = %w("#{song1}")
#   @user_new_quotes = $prompt.multi_select("Which quote would you like to add", choices)
#
#
#
# end
