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