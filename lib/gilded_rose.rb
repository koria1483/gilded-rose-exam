require 'delegate'

class GildedRose
  
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
     ItemWrapper.wrap(item)
    end 
  end

end  #end of Class GildedRose
    
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

    update(item)
  end

  def self.update(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"
    age(item)
    update_quality(item)
  end

  def self.age(item)
    item.sell_in -= 1
  end
  
  def self.update_quality(item)
    item.quality += caluculate_quality_adjustment(item)
  end  

  def self.caluculate_quality_adjustment(item)
    # This is for testing only
    
    adjustment = 0

    if item.sell_in < 0
      adjustment -= 1
    else
      adjustment -= 1
    end

    adjustment
  end
   
  def self.quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end

end

class AgedBrie < ItemWrapper
  def caluculate_quality_adjustment
    adjustment = 1
    if sell_in < 0
      adjustment += 1
    end

    adjustment
  end
end

class SulfurasItem < ItemWrapper
  def caluculate_quality_adjustment
    #This item don't change anything
  end
end

class ConjuredItem < ItemWrapper
  def caluculate_quality_adjustment
    adjustment = -2
    if sell_in < 0
      adjustment -= 2
    end

    adjustment
  end
end
