User.destroy_all
Quote.destroy_all
Favorite.destroy_all


kiki = User.create(username: "kikidunzz")
User.create(username: "aariasgonz")
User.create(username: "bigboiii3")
User.create(username: "avocadotoast2")
User.create(username: "yerrrrrr")

quote1 = Quote.create(quote:"I like to look cool and dress nice. Lil Uzi is a rock star. Just know that.", author:"Lil Uzi Vert", category:"funny")
quote2 = Quote.create(quote: "There's enough money for everybody. See, I can't do what Yachty does. But then again, Yachty can't do what I do.", author: "Lil Uzi Vert", category:"motivational")
quote5 =Quote.create(quote: "I never wanted to be no rapper", author:"Lil Uzi Vert", category:"depressing")

quote4 =Quote.create(quote: "I am good, but not an angel. I do sin, but I am not the devil. I am just a small girl in a big world trying to find someone to love", author:"Marilyn Monroe", category:"love")
quote3 =Quote.create(quote: "Fear is stupid. So are regrets", author:"Marilyn Monroe", category:"motivational")
Quote.create(quote: "Experts on romance say for a happy marriage there has to be more than a passionate love. For a lasting union, they insist, there must be a genuine liking for each other. Which, in my book, is a good definition for friendship", author:"Marilyn Monroe", category:"friendship")

Quote.create(quote: "I'm a good man, and I'm gonna become a better man", author:"Chance the Rapper", category:"motivational")
Quote.create(quote: "I didn't know love until I had my daughter. I didn't know its bounds", author:"Chance the Rapper", category:"love")
Quote.create(quote: "Walking with a friend in the dark is better than walking alone in the light", author:"Helen Keller", category:"friendship")
Quote.create(quote: "Do I not destroy my enemies when I make them my friends?", author:"Abraham Lincoln", category:"friendship")
Quote.create(quote: "I don't fear death so much as I fear its prologues: loneliness, decrepitude, pain, debilitation, depression, senility. After a few years of those, I imagine death presents like a holiday at the beach", author:"Mary Roach", category:"depressing")

Favorite.create(user: kiki, quote: quote1)
Favorite.create(user: kiki, quote: quote2)
Favorite.create(user: kiki, quote: quote3)
Favorite.create(user: kiki, quote: quote4)
Favorite.create(user: kiki, quote: quote5)
