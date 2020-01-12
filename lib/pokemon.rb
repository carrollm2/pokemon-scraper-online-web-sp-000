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


  def self.save(name, type, db)

    db.execute("INSERT INTO pokemon ( name, type) VALUES ( ?, ?)", [name, type])
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end


  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"

    result = db.execute(sql, id)[0]

    results = {id: result[0], name: result[1], type: result[2], db: db}

    Pokemon.new(results)
  end

end
