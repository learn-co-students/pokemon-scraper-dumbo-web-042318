class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  def initialize(hash, hp = nil)
    @id = hash[:id]
    @name = hash[:name]
    @type = hash[:type]
    @db = hash[:db]
    @hp = hp
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type )
  end

  def self.find(id, db)
    pokemon_attr = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    pokemon_obj = self.new({id: pokemon_attr[0], name: pokemon_attr[1], type: pokemon_attr[2], db: db}, pokemon_attr[3])
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
  end
end
