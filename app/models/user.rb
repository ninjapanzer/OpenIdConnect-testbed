class User < ActiveRecord::Base

  def find_or_create_from_auth_hash(auth_hash)
    puts auth_hash.inspect
  end
end
