class Person
    STARTING_HEALTH = 120
    attr_accessor :name, :age, :health, :strength, :dead

    def initialize(name, health = STARTING_HEALTH, age, strength)
        @name = name
        @age = age
        @health = health
        @strength = strength
        @dead = false
    end

    
    def self.create_warrior
        @name =  self.random_name
        @age = rand * 20 + 15
        @health = [@age * 5, 120].min
        @strength = [@age / 2, 10].min
    end
    
    def attack(enemy)
        shout("#{self.name} attacks!")
        enemy.take_damage(rad * 20 + self.strength)
    end
    
    
    def shout(str)
        puts str
    end
    
    def sleep
        self.health += 1 unless self.health >= 99
    end
    
    protected

    def take_damage(damage)
        self.health -= damage
        self.shout("OUCH! #{self.name} takes #{damage} and has #{self.health}left!")
        self.die if self.health <= 0
    end
    
    private

    def self.random_name
        ["Erik", "Lars", "Leif"].sample
    end
    
    def die
        puts "#{self.name} has been slain!"
        self.dead = true
    end
end

# ---------------------------- #

class Weapon
    attr_accessor :type
    attr_reader :damage, :name
    def initialize(type = ["Axe", "Sword", "Bow"].sample)
        @type = type
        @name = @type + [" of Death", " of Skulls", " of Despair"].sample
        @damage = rand * 5
    end
end

#------------------------------#

class Viking < Person
    attr_accessor :weapon

    def initialize(name, health, age, strength, weapon)
        super(name, health, age, strength)
        @weapon = weapon
    end

    def attack(enemy)
        shout("#{self.name} attacks with the #{self.weapon.name}!")
        enemy.take_damage(rand * 20 + self.strength + weapon.damage)
    end

    def self.create_warrior
        super
        @weapon = Weapon.new
        @name = @name + [", The Brutal", ", The Mad", ", The Terrible"].sample

        # require "pry-byebug"; binding.pry

        Viking.new(@name, @health, @age, @strength, @weapon)
    end
end


#warrior = Viking.new("Lars", 130, 19, 90, "Fists")
warrior = Viking.create_warrior
warrior2 = Viking.create_warrior

puts warrior.name
puts warrior2.name
puts warrior.age
puts warrior2.age
puts warrior.health
puts warrior2.health
puts warrior.strength
puts warrior2.strength
puts warrior.weapon.type
puts warrior2.weapon.type
puts warrior.dead
puts warrior2.dead

until warrior2.dead
    warrior.attack(warrior2) 
end
puts "Game Over"