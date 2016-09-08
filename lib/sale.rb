require 'csv'

module FarMar
  class Sale
    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(id, amount, purchase_time, vendor_id, product_id)
      @id = id
      @amount = amount
      @purchase_time = purchase_time
      @vendor_id = vendor_id
      @product_id = product_id
    end

    def self.all
      all_sales = {}
      CSV.read("/Users/nurl/ada/homework/FarMar/support/sales.csv").each do |line|
        all_sales[line[0].to_i] = self.new(line[0].to_i,line[1].to_i,line[2],line[3].to_i,line[4].to_i)
      end
      return all_sales
    end

    def self.find(id)
      if all.has_key?(id)
        return all[id]
      else
        raise ArgumentError.new("We do not have a sale with that ID.")
      end
    end

    def self.between(beginning_time, end_time)
      all_purchase_times = all.map do |k, v|
        v.purchase_time
      end

      raise ArgumentError.new("These dates are beyond the date range in our database") if (beginning_time < all_purchase_times.min && end_time < all_purchase_times.min ) || (beginning_time > all_purchase_times.max && end_time > all_purchase_times.max)

      all.delete_if do |k, v|
        v.purchase_time < beginning_time || v.purchase_time > end_time
      end
    end

    def vendor
      all_vendors = FarMar::Vendor.all
      return all_vendors[@id]
    end

    def product
      all_products = FarMar::Product.all
      return all_products[@id]
    end
  end
end
