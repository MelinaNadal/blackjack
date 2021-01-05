require 'Colorize'
class Card

	attr_reader :face, :suit, :value
	def initialize(face, suit, value)
		@face = face
		@suit = suit
		@value = value
	end

	def value
		return 10 if ["J", "Q", "K"].include?(@value)
		return 11 if @value =="A"
		return @value
	end

	def to_s
		"#{@value}-#{suit}"
	end
end	

class Deck
	attr_reader :cards

	def initialize
		@cards = Deck.build_cards
	end
	def deal_card player
        new_card = Card.new face, suit, value
        player.hand << new_card
        player.total = player.total + new_card.value
    end 
end


	def self.build_cards
		cards = []
		[:clubs, :diamonds, :spades, :hearts].each do |suit|
			(2..10).each do |number|
				cards << Card.new(suit, number)
			end
			["J", "Q", "K", "A"].each do |facecard|
				cards << Card.new(suit, facecard)
			end
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
					num.times {@cards.shift.deal_card(player)}
				end 
			end 		
			def welcome(name)
				print(name)
				gets
			end 	
			name = welcome("This is  to Ruby Blackjack! What's your name? ").chomp
puts "\nAre you Ready to gamble #{name.green}!?"

player.name="#{name.green}"

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

		puts "#{player.name.green}, you were dealt:"
		deck = Deck.new
        deck.deal_cards(2, player)
        puts "The #{player.hand[0].face} of #{player.hand[0].suit} (#{player.hand[0].value})"
        puts "The #{player.hand[1].face} of #{player.hand[1].suit} (#{player.hand[1].value})"
        