module Omnipotence
  def self.omnipotent? email
    (ENV['OMNIPOTENT_USERS'] || '').split(',').include? email
  end

  def omnipotent?
    Omnipotence.omnipotent? email
  end

  def blessed?
    return true if omnipotent?
    (ENV['BLESSED_DOMAINS'] || '').split(',').include? email.split('@').last
  end
end