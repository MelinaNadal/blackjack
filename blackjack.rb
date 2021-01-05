require 'rspec'
class Card

	attr_reader :suit, :value
	def initialize(suit, value)
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