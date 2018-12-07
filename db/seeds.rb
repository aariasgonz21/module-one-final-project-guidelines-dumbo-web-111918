User.destroy_all
Quote.destroy_all
Favorite.destroy_all


kiki = User.create(username: "kikidunzz")
User.create(username: "aariasgonz")
User.create(username: "bigboiii3")
User.create(username: "avocadotoast2")
User.create(username: "yerrrrrr")

#------------------------------------funny-------------------------------------------
quote1 = Quote.create(quote: "Accept who you are. Unless you're a serial killer.", author:"Ellen DeGeneres", category:"funny")
Quote.create(quote: "I may be drunk, Miss, but in the morning I will be sober and you will still be ugly.", author: "Winston Churchill", category: "funny")
Quote.create(quote: "Behind every great man is a woman rolling her eyes.", author: "Jim Carrey", category: "funny")
Quote.create(quote: "Age is something that doesn't matter, unless you are cheese.", author: "Luis Bunuel", category: "funny")
Quote.create(quote: "I love Mickey Mouse more than any woman I have ever known.", author: "Walt Disney", category: "funny")
Quote.create(quote: "I don't know her.", author: "Mariah Carey", category: "funny")
Quote.create(quote:"I like to look cool and dress nice. Lil Uzi is a rock star. Just know that.", author:"Lil Uzi Vert", category:"funny")
#-----------------------------------friendship--------------------------------
Quote.create(quote: "If I were to die right now in a fiery explosion due to carelessness of a friend…. Then it would just be alright.", author: "Spongebob", category: "friendship")
Quote.create(quote: "Friends joke with one another. 'Hey, you're poor. Hey, your momma's dead.' That's what friends do.", author: "Michael Scott-(The Office)", category: "friendship")
quote2 = Quote.create(quote: "Walking with a friend in the dark is better than walking alone in the light", author:"Helen Keller", category:"friendship")
Quote.create(quote: "Friends wouldn't ask friends to give them dresses for free.", author: "Kim Kardashian", category: "friendship")
Quote.create(quote: "When did my friends become more complicated than my math homework?", author: "Lizzie McGuire", category: "friendship")
Quote.create(quote: "Good friends will help you until you're unstuck.", author: "Winnie the Pooh", category: "friendship")
Quote.create(quote: "Do I not destroy my enemies when I make them my friends?", author:"Abraham Lincoln", category:"friendship")
Quote.create(quote: "You've got a friend in me.", author: "Toy Story", category: "friendship")
# # ----------------------------------motivational---------------------------------
Quote.create(quote: "Just keep swimming!", author: "Nemo", category: "motivational")
Quote.create(quote: "You're only a fool if you give up.", author: "Aladdin", category: "motivational")
Quote.create(quote: "If you believe in yourself and with a tiny pinch of magic, all your dreams can come true", author: "Spongebob", category: "motivational")
Quote.create(quote: "There's enough money for everybody. See, I can't do what Yachty does. But then again, Yachty can't do what I do.", author: "Lil Uzi Vert", category:"motivational")
Quote.create(quote: "No one can change a person, but someone can be a reason for that person to change.", author: "Spongebob", category: "motivational")
Quote.create(quote: "Fear is stupid. So are regrets", author:"Marilyn Monroe", category:"motivational")
quote3 = Quote.create(quote: "It's easy to do nothing, it's hard to forgive.", author: "Avatar Aang", category: "motivational")
Quote.create(quote: "I know now that no one can give you your honor. It's something you earn for yourself by choosing to do what's right.", author: "Prince Zuko", category: "motivational")
#------------------------------------love--------------------------------------------#
Quote.create(quote: "When I see your face, there's not a thing that I would change 'cause you're amazing, just the way you are.", author: "Bruno Mars", category: "love")
Quote.create(quote: "She say, Do you love me? I tell her, Only partly, I only love my bed and my momma, I'm sorry.", author: "Drake", category: "love")
Quote.create(quote: "Love is like the wind, you can't see it, but you can feel it.", author: "Nicholas Sparks", category: "love")
Quote.create(quote: "Love is a smoke and is made with the fume of sighs.", author: "William Shakespeare", category: "love")
quote4 = Quote.create(quote: "We're all a little weird, and life's a little weird. And when we find someone whose weirdness is compatible with ours, we join up with them and fall in mutual weirdness and call it love.", author: "Dr.Seuss", category: "love")
Quote.create(quote: "Love can change a person the way a parent can change a baby: awkwardly, and often with a great deal of mess.", author: "Lemony Snicket", category: "love")
Quote.create(quote: "Passion makes the world go round. Loves just makes it a safer place.", author: "Ice T", category: "love")
Quote.create(quote: "I am good, but not an angel. I do sin, but I am not the devil. I am just a small girl in a big world trying to find someone to love", author:"Marilyn Monroe", category:"love")
#------------------------------------depressing------------------------------------------------------#
Quote.create(quote: "You said you'd always be there for me, but you're not", author: "Simba", category: "depressing")
Quote.create(quote: "But if you want to leave, you can. I'll remember you though. I remember everyone that leaves", author: "Lilo", category: "depressing")
Quote.create(quote: "Please don't go away. Please? No one's ever stuck with me for so long before.", author: "Dory", category: "depressing")
Quote.create(quote: "Things change. And friends leave. Life doesn't stop for anybody.", author: "Stephen Chbosky", category: "depressing")
quote5 = Quote.create(quote: "Tears come from the heart and not from the brain.", author: "Leonardo da Vinci", category: "depressing")
Quote.create(quote: "Sometimes its a burden to be such a genius.", author: "Jimmy Neutron", category: "depressing")
Quote.create(quote: "The good times of today, are the sad thoughts of tomorrow.", author: "Bob Marley", category: "depressing")
Quote.create(quote: "I never wanted to be no rapper", author:"Lil Uzi Vert", category:"depressing")

Favorite.create(user: kiki, quote: quote1)
Favorite.create(user: kiki, quote: quote2)
Favorite.create(user: kiki, quote: quote3)
Favorite.create(user: kiki, quote: quote4)
Favorite.create(user: kiki, quote: quote5)
