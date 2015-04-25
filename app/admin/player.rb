ActiveAdmin.register Player, as: 'Player Pick' do
  menu priority: 4

  permit_params :team_id
  actions :all, except: [:new, :create, :edit, :update, :destroy]

  filter :fantasy_draft_manager, as: :select, collection: User.all.map { |user| [user.user_name, user.id] }
  filter :team, as: :select, collection: Team.all.order(:alias_name).map { |team| [team.alias_name, team.id] }
  filter :first_name
  filter :last_name
  filter :primary_position

  includes :fantasy_draft_manager, :team, :game_stats

  # config.sort_order = 'total_points_asc'

  # :nocov:
  index do
    column 'Player' do |player|
      link_to "#{player.first_name} #{player.last_name}", admin_player_pick_path(player)
    end
    column 'Team' do |player|
      player.team.alias_name
    end
    column '#' do |player|
      player.jersey_number
    end
    column :primary_position
    column 'Total Points' do |player|
      player.total_points
    end
    column 'Fantasy Draft Manager' do |player|
      link_to "#{player.fantasy_draft_manager.user_name}", admin_user_path(player.fantasy_draft_manager)
    end
  end

  show title: :full_name do
    attributes_table do
      row :first_name
      row :last_name
      row :team
      row :jersey_number
      row :primary_position
      row :fantasy_draft_manager do |player|
        link_to "#{player.fantasy_draft_manager.user_name}", admin_user_path(player.fantasy_draft_manager)
      end
    end
  end
  # :nocov:
end
