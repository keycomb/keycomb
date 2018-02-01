class Plan
  include ActiveModel::Serialization

  PLANS = [
    { id: "basic", price: 0, range: 0..0, title: "Open Comber" },
    { id: "tier1", price: 49, range: 1..4, title: "Lite Comber" },
    { id: "tier2", price: 99, range: 5..10, title: "Comber" },
    { id: "tier3", price: 249, range: 11..30, title: "Large Comber" },
  ].freeze

  attr_reader :id, :price, :title

  def initialize(id:, range:, price:, title:)
    @id = id
    @range = range
    @price = price
    @title = title
  end

  def self.all
    PLANS.map { |plan| new(plan) }
  end

  def self.find_by(count:)
    found = PLANS.detect { |plan| plan.fetch(:range).include?(count) }
    new(found)
  end

  def ==(other)
    id == other.id
  end

  def allowance
    range.max
  end

  def open_source?
    price.zero?
  end

  private

  attr_reader :range
end
