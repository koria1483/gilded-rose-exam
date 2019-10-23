require 'delegate'

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each do |item|
      ItemWrapper.wrap(item).update
    end
  end

end

class ItemWrapper < SimpleDelegator
  def self.wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    when "Conjured Mana Cake"
      ConjuredItem.new(item)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasItem.new(item)
    else
      new(item)
    end
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    age
    update_quality
  end

  def age
    self.sell_in -= 1
  end

  def update_quality
    retun self.quality = 0 if 
    self.quality += calculate_quality_adjustment
  end

  def calculate_quality_adjustment
    adjustment = 0

    if sell_in < 0
      adjustment -= 1
    else
      adjustment -= 1
    end

    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class AgedBrie < ItemWrapper
  def calculate_quality_adjustment
    adjustment = 1
    if sell_in < 0
      adjustment += 1
    end

    adjustment
  end
end

class BackstagePass < ItemWrapper
  def calculate_quality_adjustment
    adjustment = 1
    if sell_in < 11
      adjustment += 1
    end
    if sell_in < 6
      adjustment += 1
    end
    if sell_in < 0
      adjustment -= quality
    end

    adjustment
  end
end

class ConjuredItem < ItemWrapper
  def calculate_quality_adjustment
    adjustment = -2
    if sell_in < 0
      adjustment -= 2
    end

    adjustment
  end
end

class SulfurasItem < ItemWrapper
  def calculate_quality_adjustment
    #This item don't change anything
  end
end

