class Player 
	attr_accessor :name, :hand, :bankroll, :total
	def initialize name, hand, bankroll, total
		@name = name
		@hand = []
		@bankroll = bankroll
		@total = total
	end
end

player = Player.new "Player", [], 100, 0
the_house = Player.new "The House", [], 10000, 0	


class Deck
	def initialize
		@faces = [*(2..10), 'Jack', 'Queen', 'King', 'Ace']
		@suits = ['♣︎', '♠︎', '❤️', '♦︎']
		@cards = []
		@faces.each do |face|
			if face.class == Integer
				value = face
			elsif face == 'Ace'
				value = 11
			else 
				value = 10
			end
			@suits.each do |suit|
				@cards << Card.new(face, suit, value)
			end 
		end
	@cards.shuffle!
	end 				
	def deal_cards(num, player)
		num.times{@cards.shift.generate_card(player)}
	end 
end 		


class Card

	attr_reader :face, :suit, :value
	def initialize(face, suit, value)
		@face = face
		@suit = suit
		@value = value
	end

	def generate_card (player)
		new_card=Card.new face, suit, value
		player.hand << new_card
		player.total += new_card.value
	end
	end
	



		puts "This is  to Ruby Blackjack! What's your name? "
		name = gets.chomp
puts "\nAre you Ready to gamble #{name}!?"

player.name="#{name}"

loop do
    puts "(D)eal or (Q)uit"
    play = gets.chomp.downcase
    if play == "q"
        puts "See ya next time"
        break
    else 
        puts "\nDealing... "
        player.hand.clear
        player.total = 0 
        the_house.hand.clear
        the_house.total = 0

		puts "#{player.name}, you were dealt:"
		deck = Deck.new
        deck.deal_cards(2, player)
        puts "The #{player.hand[0].face} of #{player.hand[0].suit} (#{player.hand[0].value})"
		puts "The #{player.hand[1].face} of #{player.hand[1].suit} (#{player.hand[1].value})"
		deck.deal_cards(2, the_house)
        puts "\n#{the_house.name}"
        puts "The #{the_house.hand[0].face} of #{the_house.hand[0].suit} (#{the_house.hand[0].value})"

        until player.total >= 21 do
            puts "\n\n(H)it or (S)tand?"
            hit = gets.chomp.downcase
                if hit == 'h'
                    deck.deal_cards(1, player)
                    puts "\n#{player.name}, your new card is:"
                    puts "The #{player.hand[0].face} of #{player.hand[0].suit} (#{player.hand[0].value})\n"
                    puts "The total in your hand is: #{player.total}"
				    puts "\n\nThe dealer has one card showing: The #{the_house.hand[0].face} of #{the_house.hand[0].suit} (#{the_house.hand[0].value})"
                else
                    break
                end
            end
			puts "\n\n#{player.name}, your hand has a total value of #{player.total}"
            puts "The #{the_house.name} has a hand value of #{the_house.total}\n"
			if player.total <= 21 && the_house.total <=21
				if player.total > the_house.total
					puts "\n#{player.name}, you won!"
					player.bankroll += 10
					the_house.bankroll -= 10
				elsif player.total < the_house.total
					puts "\nThe #{the_house.name} won!"
					player.bankroll -= 10
					the_house.bankroll += 10
				else 
					puts "\nIts a tie"
				end 
			elsif player.total > 21 && the_house.total <= 21
				puts "\n\n#{player.name}, you have gone over 21 and lose this round."
				player.bankroll -= 10
				the_house.bankroll += 10
					
			elsif player.total <= 21 && the_house.total > 21
				puts "#{the_house.name} went over 21. #{player.name}, you win this round."
				player.bankroll -= 10
				the_house.bankroll += 10
			else player.total > 21 && the_house.total > 21
				puts "#{player.name}, you and #{the_house.name} have tied"
			end 
			puts "\n\n#{player.name}, you now have $#{player.bankroll}."
			puts "#{the_house.name}, now has $#{the_house.bankroll}."
			if player.bankroll <= 0
				puts "\nYou're new balance is $0 YOU LOSE"
				break
			end
		end 
	end
	