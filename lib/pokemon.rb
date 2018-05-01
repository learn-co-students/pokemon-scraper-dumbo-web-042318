require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  def initialize(hash)
    @id = hash.fetch(:id)
    @name = hash.fetch(:name) 
    @type = hash.fetch(:type)
    @hp = hash.fetch(:hp, nil)
    @db = hash.fetch(:db)
  end

  def self.save(name,type,db, hp=nil)
    if hp
      sql = "
      INSERT INTO #{self.name} (name,type,hp) VALUES 
      ('#{name}','#{type}','#{hp}');"
    else 
    sql = "
      INSERT INTO #{self.name} (name,type) VALUES 
      ('#{name}','#{type}');"
    end
    db.execute(sql)
  end

  def self.find(id,db)
    sql = "
    SELECT *
    FROM #{self.name}
    WHERE id = #{id};"
    pokemon_arr = db.execute(sql).flatten
    if pokemon_arr.length == 3
      pokemon = Pokemon.new({id: id, name: pokemon_arr[1], type: pokemon_arr[2], db: db, hp: pokemon_arr[3]})
      self.save(pokemon.name, pokemon.type, db)
    else
      pokemon = Pokemon.new({id: id, name: pokemon_arr[1], type: pokemon_arr[2], db: db, hp: 60})
      self.save(pokemon.name, pokemon.type, db, 60)
    end

    return pokemon
  end


end
