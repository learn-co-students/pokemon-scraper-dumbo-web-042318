class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(hash, hp = nil)
    @id = hash.fetch(:id)
    @name = hash.fetch(:name)
    @type = hash.fetch(:type)
    @db = hash.fetch(:db)
    @hp = hp

    # @db.execute( "INSERT INTO Pokemon (id, name, type) VALUES (?, ?, ?)",  [@id, @name, @type] )
  end

  def self.save(name, type, db)

    db.execute( "INSERT INTO Pokemon (name, type) VALUES (?, ?)", [name, type] )
  end

  def self.find(id, db)

    arr = db.execute( "SELECT * FROM Pokemon WHERE id = (?)", [id]).flatten
    obj = self.new({id: arr[0], name: arr[1], type: arr[2], db: db}, arr[3])
  end

  def alter_hp(new_hp, db)
    db.execute( "UPDATE Pokemon SET hp = ?", [new_hp])
  end
end
