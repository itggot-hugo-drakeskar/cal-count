DataMapper.setup(:default, 'sqlite:info.sqlite')

# Main database setup

class Users
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, Text
  property :password, BCryptHash
  property :bmr, Integer
  property :consumed, Integer
end

class Dishes
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, Text
  property :kcal, Integer
end

DataMapper.finalize
DataMapper.auto_upgrade!
