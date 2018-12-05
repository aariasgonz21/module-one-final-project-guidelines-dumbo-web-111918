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
