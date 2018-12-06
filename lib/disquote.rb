$prompt = TTY::Prompt.new

#------------------------Welcome Screen-----------------#
def screen1
  puts ""
  @screen1 = [
    {"Login" => -> do login end},
    {"Register" => -> do register end},
    {"Exit" => -> do exit end}
  ]
  $prompt.select("Disquote: Helping you find this quote!\n", @screen1)
end

#--------------------Register Screen--------------------#

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

 #---------------------------Login Screen-----------------------#

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
    @login_options = [
      {"Try Again" => -> do login end},
      {"Register" => -> do register end},
      {"Aigh Fuck It" => -> do exit end}
    ]
    $prompt.select("User not found! Try Again?\n", @login_options)
  end

  #asking for password
  lock = $prompt.decorate('🔒')
  @password = $prompt.mask("Please enter your password:", mask:lock) do |p|
    p.required true
    p.validate /^[0-9a-zA-Z]{8,}*$/
    p.messages[:valid?] = "Invalid password! Password must only contain A-Z or 0-9, and must be at least 8 characters long"
  end
end

#--------------------Home Screen----------------------#
def home
  @home = [
    {"Help" => -> do help end},
    {"View List" => -> do view_list end},
    {"Search" => -> do search end},
    {"Log Out" => -> do screen1 end},
  ]
  $prompt.select("---------------------------Main Menu--------------------------\n", @home)
end

#-------------------Buttons-----------------#
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

#----------------------Pages-------------------------#

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
  go_back
end

def view_list
  binding.pry

  puts "Your Favorite Quotes: "
  puts @user.quote_strings
  @user.reload

  if @user.favorites == []
    go_back("You don't have any quotes yet. Search for some quotes to add!")
  end

  @view_list = [
    {"Go Back" => -> do home end},
    {"Add to List" => -> do search end},
    {"Create Quote to List" => -> do create_quote end},
    {"Delete from List" => -> do delete_quote end}
  ]
  $prompt.select("",@view_list)
end


def search
  puts "Would you like to search by category or all"
  @search_options = [
    {"Categories" => -> do search_by_category end},
    {"All" => -> do search_all end},
    {"Go Back" => -> do home end}
  ]

  $prompt.select("", @search_options)

end

def search_by_category
#binding.pry
@selection = [
  {Quote.categories[0] => -> do funny_quotes end},
  {Quote.categories[1] => -> do motivational_quotes end},
  {Quote.categories[2] => -> do depressing_quotes end},
  {Quote.categories[3] => -> do love_quotes end},
  {Quote.categories[4] => -> do friendship_quotes end}

]

$prompt.select("Choose your category?", @selection)
  # elsif @selection == "funny"
  #   funny_quotes
end


#----------------------------Functionalities--------------------#

def create_quote
  @make_ur_own = $prompt.ask("Enter your quote: ")
  Favorite.create(user_id: @user.id, quote_id: @make_ur_own)
  puts "Added to List!"
  view_list
end

def delete_quote
  binding.pry
  #choices
  prompt.multi_select()

end


#------------------categories------------------#
  def motivational_quotes
    choice_and_back = [
      Quote.motivational_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
  @choice_result_2 =
      $prompt.select("Which quote would you like to add?", choice_and_back)
      # do |menu|
      # menu.choice "There's enough money for everybody. See, I can't do what Yachty does. But then again, Yachty can't do what I do."
      # menu.choice "Fear is stupid. So are regrets"
      # menu.choice "I'm a good man, and I'm gonna become a better man"
    # end
    #binding.pry
    Favorite.create(user_id: @user.id, quote_id: @choice_result_2)
    puts "Added to List!"
    view_list
  end

  def choice_and_back(quote_category)
    choice_and_back = [
      Quote.quote_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
  end

  def funny_quotes
    choice_and_back = [
      Quote.funny_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
    @choice_result_3 =
        $prompt.select("Which quote would you like to add?", choice_and_back)
      Favorite.create(user_id: @user.id, quote_id: @choice_result_3)
      puts "Added to List!"
      view_list
  end

  def love_quotes
    choice_and_back = [
      Quote.love_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
  @choice_result_4 =
      $prompt.select("Which quote would you like to add?", choice_and_back)
    Favorite.create(user_id: @user.id, quote_id: @choice_result_4)
    puts "Added to List!"
    view_list
  end

  def friendship_quotes
    choice_and_back = [
      Quote.friendship_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
  @choice_result_5 =
      $prompt.select("Which quote would you like to add?", choice_and_back)
    Favorite.create(user_id: @user.id, quote_id: @choice_result_5)
    puts "Added to List!"
    view_list
  end

  def depressing_quotes
    choice_and_back = [
      Quote.depressing_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
  @choice_result_6 =
      $prompt.select("Which quote would you like to add?", choice_and_back)
    Favorite.create(user_id: @user.id, quote_id: @choice_result_6)
    puts "Added to List!"
    view_list
  end
