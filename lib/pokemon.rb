require_relative "../bin/environment.rb"

class Pokemon

  attr_accessor :name, :db, :type
  attr_reader :id

  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end


  def self.create(name, type, db)
    pokemon = Pokemon.new(name, type, db)
    pokemon.save
    pokemon
  end


  def self.new_from_db(row)
    new_pokemon = self.new(row[0], row[1], row[2], row[3])
    new_pokemon  # return the newly created instance
  end


  def self.save(name, type, db)

    db.execute("INSERT INTO pokemon ( name, type) VALUES ( ?, ?)", [name, type])
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end


  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    result = db.execute(sql, id)[0]

    Pokemon.new_from_db(result)
    # Pokemon.new(result[0], result[1], result[2])
  end

end
