require 'uuidtools'

module UuidGenerator
  def uuid
    UUIDTools::UUID.random_create.to_s
  end
end