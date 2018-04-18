ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  # ActiveAdmin::Dashboards.build do

  content title: proc{ I18n.t("active_admin.dashboard") } do
    orders = Order.all
    history = History.all
    columns do
      column do
        panel "Order notification" do
          table_for history.where('change_time > ? ', Time.now - 7.days).order('change_time desc') do |t|
            t.column("Order") { |hist| Order.find(hist.order_id) }
            t.column("From status") { |hist| Status.find(Transition.find(hist.status_transition_id).status_from_id).name }
            t.column("To status") { |hist| Status.find(Transition.find(hist.status_transition_id).status_to_id).name }
            t.column("Change Date") { |hist| hist.change_time}
          end
        end

        panel "Orders had to be delivered in this week" do
          table_for orders.where('finish_date > ? and finish_date < ?', Time.now, 1.week.from_now).order('finish_date') do |t|
            t.column("Order") { |order| order}
            t.column("Status") { |order| Status.find(order.status_id).name }
            t.column("Assigned To") { |order| if order.assigned_to_user_id then User.find(order.assigned_to_user_id) else " " end}
            t.column("Start Location") { |order| Location.find(order.start_location_id)}
            t.column("Finish Location") { |order| Location.find(order.finish_location_id)}
            t.column("Finish Date") { |order| order.finish_date}
          end
        end
        panel "Late orders" do
          table_for orders.where('finish_date < ? and status_id not in (select ID from STATUSES where CODE = ?)', Time.now ,'CLOSE') do |t|
            t.column("Order") { |order| order}
            t.column("Status") { |order| Status.find(order.status_id).name }
            t.column("Assigned To") { |order| if order.assigned_to_user_id then User.find(order.assigned_to_user_id) else " " end}
            t.column("Start Location") { |order| Location.find(order.start_location_id)}
            t.column("Finish Location") { |order| Location.find(order.finish_location_id)}
            t.column("Finish Date") { |order| order.finish_date}
          end
        end
      end
    end
  end # content
end

