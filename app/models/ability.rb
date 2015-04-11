class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    user.roles.flat_map(&:rights).flat_map(&:abilities).each do |ability|
      can *ability.reverse
    end

    can [:read, :options], Node
    can [:show], Page

    can :download_archive, Node do |node|
      node.archive.present?
    end
  end
end

