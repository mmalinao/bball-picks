ActiveAdmin.register Game do
  menu priority: 3

  actions :all, except: [:new, :create, :edit, :update, :destroy]

  scope :all
  scope :closed
  scope :inprogress
  scope :scheduled
  scope :inprogress_or_scheduled, default: true

  includes :home_team, :away_team

  # :nocov:
  index do
    column 'Game' do |game|
      link_to game.display_title, admin_game_path(game)
    end
    column :scheduled
    column 'Status' do |game|
      if game.closed?
        status_tag game.status
      elsif game.inprogress?
        status_tag game.status, :warning
      else
        status_tag game.status, :error
      end

      status_tag 'Stats Downloaded', :ok if GameSummary.exists?(game.id)
    end
  end

  show title: :display_title do
    attributes_table do
      row :scheduled
      row :series do |game|
        link_to "#{game.series.title}", admin_series_path(game.series)
      end
      row :away_team
      row :home_team
      row :status
      row :id
    end

    panel 'Game Summary' do
      table_for GameStats.includes(player: [:team, :fantasy_draft_manager]).where(game_id: game.id).order(points: :desc) do
        column 'Player' do |gamestats|
          link_to "#{gamestats.player.first_name} #{gamestats.player.last_name}", admin_player_pick_path(gamestats.player)
        end
        column 'Team' do |gamestats|
          gamestats.player.team.alias_name
        end
        column 'Points', :points
        column 'Fantasy Draft Manager' do |gamestats|
          link_to "#{gamestats.player.fantasy_draft_manager.user_name}", admin_user_path(gamestats.player.fantasy_draft_manager)
        end
      end
    end
  end

  action_item :refresh, only: :show, if: -> { current_user.admin? } do
    link_to 'Refresh', refresh_admin_game_path, method: :post, class: 'flat-btn'
  end
  # :nocov:

  member_action :refresh, method: :post do
    if current_user.admin?
      resource.refresh_stats
      flash[:notice] = 'Refreshed game summary'
    end
    redirect_to admin_game_path(resource)
  end

  controller do
    def index
      params[:order] = 'scheduled_asc'
      super
    end
  end
end
