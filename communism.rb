class Household
  attr_accessor :income, :consumption

  def initialize
    @income = 0
    @consumption = 0
  end

  def work(hours, wage)
    self.income += hours * wage
  end

  def consume(amount)
    if self.income >= amount
      self.consumption += amount
      self.income -= amount
    else
      puts "Not enough income for this consumption."
    end
  end
end

class Firm
  attr_accessor :production, :labor_cost

  def initialize
    @production = 0
    @labor_cost = 0
  end

  def produce(labor, wage)
    self.production += labor * 2  # Just a simple multiplier for production
    self.labor_cost += labor * wage
  end

  def sell_goods(amount, price)
    if self.production >= amount
      self.production -= amount
      return amount * price
    else
      puts "Not enough goods for this sale."
      return 0
    end
  end
end

# Creating instances
household = Household.new
firm = Firm.new

# A household works for a firm
household.work(8, 10)
firm.produce(8, 10)

# The household consumes goods
income_from_sale = firm.sell_goods(5, 20)
household.consume(income_from_sale)


class Worker
  attr_accessor :hours, :wage

  def initialize
    @hours = 0
    @wage = 0
  end

  def work_for(hours, wage)
    self.hours = hours
    self.wage = wage
  end
end

class Union
  attr_accessor :workers

  def initialize
    @workers = []
  end

  def add_worker(worker)
    workers << worker
  end

  def collective_bargain(firm)
    # The union collectively bargains for better wages.
    # This is a simplified example, actual bargaining would be much more complex.
    average_wage = workers.map(&:wage).sum / workers.size.to_f
    if average_wage < firm.wage
      firm.wage = average_wage + 5 # Increase wage by 5 after successful bargain
    end
  end
end

class Firm
  attr_accessor :wage, :production, :labor_cost

  def initialize
    @wage = 20
    @production = 0
    @labor_cost = 0
  end

  def hire_worker(worker)
    worker.work_for(8, @wage)
    @production += worker.hours * 2  # Just a simple multiplier for production
    @labor_cost += worker.hours * @wage
  end
end

# Creating instances
workers = Array.new(10) { Worker.new }
union = Union.new
firm = Firm.new

workers.each do |worker|
  union.add_worker(worker)
  firm.hire_worker(worker)
end

union.collective_bargain(firm)

puts "Firm's wage after collective bargaining: #{firm.wage}"

class Cooperative
  attr_accessor :wage, :production, :labor_cost, :workers

  def initialize(workers)
    @wage = 20
    @production = 0
    @labor_cost = 0
    @workers = workers
  end

  def operate(hours)
    @workers.each do |worker|
      worker.work_for(hours, @wage)
      @production += worker.hours * 2  # Just a simple multiplier for production
      @labor_cost += worker.hours * @wage
    end
  end
end

# Creating instances
workers = Array.new(10) { Worker.new }
cooperative = Cooperative.new(workers)

# The workers, now a cooperative, operate the firm
cooperative.operate(8)

puts "Cooperative's production after workers taking over: #{cooperative.production}"
puts "Cooperative's labor cost after workers taking over: #{cooperative.labor_cost}"

# Creating instances
workers = Array.new(10) { Worker.new }
union = Union.new
firm = Firm.new
households = Array.new(10) { Household.new }

workers.each do |worker|
  union.add_worker(worker)
  firm.hire_worker(worker)
end

# Workers work and get paid a wage, which becomes their income
workers.each do |worker|
  corresponding_household = households[workers.index(worker)]
  corresponding_household.work(worker.hours, worker.wage)
end

# The firm sells its goods
income_from_sale = firm.sell_goods(firm.production, 20)

# Households consume goods, but the cost of goods is too high!
households.each do |household|
  household.consume(income_from_sale / households.size)
end

puts "The firm's profit after selling goods: #{income_from_sale - firm.labor_cost}"

# Now, workers unionize and demand higher wages
union.collective_bargain(firm)

# The firm agrees to increase the wage
workers.each do |worker|
  worker.work_for(worker.hours, firm.wage)
end

# The firm sells its goods again, but at a higher price to maintain its profit margin
income_from_sale = firm.sell_goods(firm.production, 25)

# Households consume goods again, but the cost is now even higher!
households.each do |household|
  household.consume(income_from_sale / households.size)
end

puts "The firm's profit after selling goods with increased wage: #{income_from_sale - firm.labor_cost}"


# After seeing the unchanged profit of the firm and their cost of living going up,
# workers decide to form a cooperative.
cooperative = Cooperative.new(workers)
require "debug"
# Workers, now part of the cooperative, decide to operate for the same hours
cooperative.operate(8)

# The cooperative sells its goods, setting a fair price
income_from_sale = cooperative.production * 20  # Price per unit is 20

# Households consume goods, but this time, the cost of goods is fairer and more affordable!
households.each do |household|
  household.consume(income_from_sale / households.size)
end

puts "The cooperative's shared profit after selling goods: #{income_from_sale - cooperative.labor_cost}"

# Workers, being part of the cooperative, enjoy their fair share of the profit
shared_profit = (income_from_sale - cooperative.labor_cost) / workers.size
workers.each do |worker|
  corresponding_household = households[workers.index(worker)]
  corresponding_household.income += shared_profit  # Workers receive their share of the profit as income
end

# Households, having a better income, can now consume more goods!
households.each do |household|
  household.consume(income_from_sale / households.size)
end

puts "Households' consumption after workers form a cooperative: #{households.sum(&:consumption)}"


require 'singleton'

class Chaos
  include Singleton

  def natural_disaster(cooperative)
    # Reduce production by a random percentage between 10% and 50%
    reduction = rand(10..50) / 100.0
    cooperative.production *= (1 - reduction)
    puts "A natural disaster reduced the cooperative's production by #{reduction * 100}%."
  end

  def strike(workers)
    # Reduce hours worked by a random amount between 1 and 3
    reduction = rand(1..3)
    workers.each { |worker| worker.hours -= reduction if worker.hours > reduction }
    puts "A strike reduced the workers' hours by #{reduction}."
  end
end

# The cooperative continues to operate as usual...
cooperative.operate(8)

# But then, Chaos intervenes with a natural disaster!
Chaos.instance.natural_disaster(cooperative)

# The cooperative sells its goods, but there are fewer goods due to the natural disaster
income_from_sale = cooperative.production * 20  # Price per unit is 20

# Households consume goods, but there are fewer goods available
households.each do |household|
  household.consume(income_from_sale / households.size)
end

puts "The cooperative's shared profit after selling goods affected by a natural disaster: #{income_from_sale - cooperative.labor_cost}"

# Next, Chaos incites a strike among the workers
Chaos.instance.strike(workers)

# The cooperative tries to operate, but with reduced hours due to the strike
cooperative.operate(8)

# The cooperative sells its goods, but there are fewer goods due to the reduced labor
income_from_sale = cooperative.production * 20  # Price per unit is 20

# Households consume goods, but there are fewer goods available due to the strike
households.each do |household|
  household.consume(income_from_sale / households.size)
end

puts "The cooperative's shared profit after selling goods affected by a strike: #{income_from_sale - cooperative.labor_cost}"

binding.break
