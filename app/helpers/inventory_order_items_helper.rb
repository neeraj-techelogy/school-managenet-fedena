module InventoryOrderItemsHelper
  def add_inventory_order_item_link(name)
    link_to_function name, :class => "btn" do |page|
      page.insert_html :bottom, :inventory_order_items, :partial =>'inventory_order_item', :object => InventoryOrderItem.new
    end
  end
end
