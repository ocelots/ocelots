module Omnipotence
  def self.omnipotent? email
    (ENV['OMNIPOTENT_USERS'] || '').split(',').include? email
  end

  def omnipotent?
    Omnipotence.omnipotent? email
  end
end