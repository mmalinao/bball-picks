ActiveAdmin.register Series do
  menu priority: 2

  actions :all, except: [:new, :create, :edit, :update, :destroy]

  filter :start_date, as: :date_range
  filter :status, as: :string
  filter :round, as: :string

  scope :all
  scope :closed
  scope :inprogress, default: true
  scope :scheduled

  # :nocov:
  index do
    column 'Series' do |series|
      link_to series.title, admin_series_path(series)
    end
    column :start_date
    column :status
    column :round
  end

  action_item :refresh, only: :index, if: -> { current_user.admin? } do
    link_to 'Refresh', refresh_admin_series_index_path, method: :post, class: 'flat-btn'
  end
  # :nocov:

  collection_action :refresh, method: :post do
    if current_user.admin?
      Series.refresh
      flash[:notice] = 'Refreshed series and game schedules'
    end
    redirect_to collection_path
  end

  controller do
    def index
      params[:order] = 'start_date_asc'
      super
    end
  end
end
