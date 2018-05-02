require 'pry'

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(pokemon)
    #binding.pry
    @id = pokemon[:id]
    @name = pokemon[:name]
    @type =  pokemon[:type]
    @db = pokemon[:db]
    @hp = pokemon[:hp]
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?);
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)
    db.results_as_hash = true
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    new_pokemon = db.execute(sql, id)[0]
    new_pokemon = new_pokemon.inject({}){|new, (k,v)| new[k.to_sym] = v if k.is_a?(String); new}
    Pokemon.new(new_pokemon)
  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL
    db.execute(sql, new_hp, self.id)
  end


end
