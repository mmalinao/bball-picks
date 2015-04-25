ActiveAdmin.register User do
  menu priority: 5

  permit_params :password, :password_confirmation

  actions :all, except: [:new, :create, :destroy]

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  # :nocov:
  index do
    column :user_name do |user|
      link_to user.user_name, admin_user_path(user)
    end
    column :email
    column 'Total Points' do |user|
      user.total_points
    end
    column :actions do |user|
      links = link_to I18n.t('active_admin.view'), admin_user_path(user)
      if user == current_user
        links += link_to I18n.t('active_admin.edit'), edit_admin_user_path(user)
      end
      links
    end
  end

  show title: :user_name do
    attributes_table do
      row :user_name
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
    end

    panel 'Picks' do
      table_for user.picks.includes(:game_stats, :team).order('game_stats.points desc') do
        column 'Player' do |player|
          link_to "#{player.full_name}", admin_player_pick_path(player)
        end
        column 'Team' do |player|
          player.team.alias_name
        end
        column 'Points' do |player|
          player.total_points
        end
      end
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  action_item :edit, only: :show, if: -> { current_user == user } do
    link_to 'Edit', edit_admin_user_path, class: 'flat-btn'
  end
  # :nocov:
end
