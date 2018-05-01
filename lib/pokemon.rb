require 'pry'
class Pokemon

  @@all = []

  attr_accessor :id, :name, :type, :db

  def initialize(db)
      @name = name
      @type = type
      @db = db
      @id = id
      #@@all << self
    end

    def self.save(name, type, db)
      db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.table_name
    self.name.downcase
  end

    def self.find(id, db)
      # binding.pry
    sql = "SELECT * FROM #{table_name} WHERE id = ?"
    results = db.execute(sql, id)



    #binding.pry

    # return nil if results.empty?

    result = results[0]
    newpoke = self.new(db)
    newpoke.id = result[0]
  #  equal are new poemons id
  newpoke.name = result[1]
  newpoke.type = result[2]
   # binding.pry
   newpoke
    end

end
