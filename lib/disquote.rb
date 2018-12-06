$prompt = TTY::Prompt.new

#------------------------Welcome Screen-----------------#
def screen1
  system "clear"
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
   system "clear"
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
  system "clear"
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
  system "clear"
  @home = [
    {"Help" => -> do help end},
    {"View List" => -> do view_list end},
    {"Search" => -> do search end},
    {"Log Out" => -> do exit_screen end},

  ]
  $prompt.select("---------------------------Main Menu--------------------------\n", @home)
end

#---------------------rating exit screen--------------------#
def exit_screen
  system "clear"
slider
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
  system "clear"
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
#binding.pry
system "clear"
@user.reload
  puts "Your Favorite Quotes: "
  @user.favorite_strings.each do |quote|
    #binding.pry
    puts quote
  end
  if @user.favorites == []
    system "clear"
    go_back("You don't have any quotes yet. Search for some quotes to add!")
  end
  @view_list = [
    {"Go Back" => -> do home end},
    {"Add to List" => -> do search end},
    {"Create Quote to List" => -> do create_quote end},
    {"Delete from List" => -> do delete_quote end},
    {"Log Out" => -> do exit_screen end},
  ]
  $prompt.select("",@view_list)
end


def search
  system "clear"
  puts "Would you like to search by category or all"
  @search_options = [
    {"Categories" => -> do search_by_category end},
    {"All" => -> do search_all end},
    {"Go Back" => -> do home end},
    {"Log Out" => -> do exit_screen end},
  ]
  $prompt.select("", @search_options)
end

def search_by_category
system "clear"
#binding.pry
  @selection = [
    {Quote.categories[0] => -> do funny_quotes end},
    {Quote.categories[1] => -> do motivational_quotes end},
    {Quote.categories[2] => -> do depressing_quotes end},
    {Quote.categories[3] => -> do love_quotes end},
    {Quote.categories[4] => -> do friendship_quotes end}
  ]
  $prompt.select("Choose your category?", @selection)
end

#----------------------------Functionalities--------------------#

def create_quote
  system "clear"
  quote_cont = $prompt.ask("Enter your quote content")
  quote_author = $prompt.ask("Enter your quote author")
  quote_category = $prompt.select("Choose your category?", Quote.categories)

  puts ("Content: ") + quote_cont + (" -- ") +("Author: ") +  quote_author + (" -- ") +("Category: ") + quote_category
aa = $prompt.yes?("Is this quote?")

 if aa
  system "clear"
  Quote.create(quote: quote_cont, author: quote_author, category: quote_category)
  @view_list = [
    {"Go Back" => -> do home end},
    {"Add to List" => -> do search end},
    {"Create Quote to List" => -> do create_quote end},
    {"Delete from List" => -> do delete_quote end},
    {"Log Out" => -> do exit_screen end},
  ]
  $prompt.select("",@view_list)
else
  system "clear"
@mistake = [
  {"Go Back" => -> do create_quote end},
  {"Go Home" => -> do home end},
  {"View list" => -> do view_list end},
  {"Search Quotes" => -> do search_by_category end},
  {"Log Out" => -> do exit_screen end},
]
$prompt.select("Mistakes happen!!! What now?!?!", @mistake)
  end
end

def delete_quote
  system "clear"
  choices = (@user.favorite_strings.map{|favorite| favorite})
  del_arr = $prompt.select("Which quote would you like to delete?", choices)

  favorite_to_delete = @user.favorites.detect do |favorite|
    del_arr.include?(favorite.quote.quote)
  end

  aa= $prompt.yes?('Are you sure you want to delete?')
  if aa == true
    favorite_to_delete.destroy
    @user.reload
    view_list
  else
    puts "Okay no problem! We all make mistakes!"
    go_back
  end
end

def slider
  system "clear"
  aa = $prompt.slider("Rate our app before you go?", max:10)
  if aa < 5
    puts ("Wow! Only a #{aa}!!! That's terrible we worked so hard!")
  elsif aa > 5 && aa != 10
    puts("A #{aa}? I guess thats not so bad..")
  else
    puts ("A #{aa}!!! Thats a perfect score! You're Awesome!")
  end
end

#------------------categories------------------#
# def choice_and_back(quote_category)
#   choice_and_back = [
#     Quote.quote_category.map{|quote| quote.to_tty_hash},
#     {"Go Back" => -> do search_by_category end}
#   ]
# end

  def motivational_quotes
    system "clear"
    choice_and_back = [
      Quote.motivational_category.map{|quote| quote.to_tty_hash},
      {"Go Back" => -> do search_by_category end}
    ]
  @choice_result_2 =
    $prompt.select("Which quote would you like to add?", choice_and_back)
    Favorite.create(user_id: @user.id, quote_id: @choice_result_2)
    puts "Added to List!"
    view_list
  end

  def funny_quotes
    system "clear"
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
    system "clear"
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
    system "clear"
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
  system "clear"
      $prompt.select("Which quote would you like to add?", choice_and_back)
    Favorite.create(user_id: @user.id, quote_id: @choice_result_6)
    puts "Added to List!"
    view_list
  end
