class Ability
	include CanCan::Ability

	def initialize(current_user)
		current_user ||= User.new
		if current_user.email == 'admin'
			can :manage, :all
		else
			can :read, :all, :download => true
			can :download, :all
			can :downloadwayleave, :all
		end
	end
end