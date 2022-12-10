# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario,cliente)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    usuario ||= Usuario.new

    if usuario.has_role? :admin
      can :manage, Usuario
      can :manage, Cliente
      can :manage, Sucursal

    elsif usuario.has_role? :personal
      can :read, Sucursal
      can :read, Cliente

      can :index_personal, Turno, estado: 'pendiente'
      can :atender_turno, Turno, sucursal_id: usuario.sucursal.id, estado: 'pendiente'
      can :atender, Turno, sucursal_id: usuario.sucursal.id, estado: 'pendiente'
      can :read, Turno, sucursal_id: usuario.sucursal.id, estado: 'pendiente'

    else
      #esto puedo hacerlo para los dos modelos???
      cliente ||= Cliente.new
      can :index_cliente, Turno
      can :get_horarios, Turno
      can :create, Turno
      can :read, Turno, cliente_id: cliente.id
      can :update, Turno, cliente_id: cliente.id, estado: 'pendiente'
      can :destroy, Turno, cliente_id: cliente.id, estado: 'pendiente'
    end

  end
end
