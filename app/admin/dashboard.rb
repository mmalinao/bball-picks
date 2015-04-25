ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  # :nocov:
  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.

    columns do
      column do
        panel "Standings" do
          table_for User.all do
            column 'Fantasy Draft Manager' do |user|
              user.user_name
            end
            column 'Total Points' do |user|
              user.total_points
            end
            column 'Top Pick' do |user|
              link_to("#{user.top_pick.first_name} #{user.top_pick.last_name}", admin_player_pick_path(user.top_pick)) + content_tag(:span, " (#{user.top_pick.total_points_info})")
            end
          end
        end
      end

      # column do
      #   panel "Top 10 Picks" do

      #   end
      # end
    end
  end # content
  # :nocov:
end
