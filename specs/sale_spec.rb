require_relative 'spec_helper'

describe FarMar::Sale do
  before (:each) do
    @sale = FarMar::Sale.new(1,200,"12:00",1,1)
  end

  describe "#initialize" do
    it "should create a new instance of Sale" do
      @sale.must_be_instance_of FarMar::Sale
    end
  end

  describe "#self.all" do
    it "should return a hash" do
      FarMar::Sale.all.must_be_kind_of Hash
    end

    it "should have a hash key of \"1\" (as a fixnumx)" do
      hash = FarMar::Product.all
      hash.has_key?(1).must_equal true
    end
  end

  describe "#self.find" do
    it "should return an instance of Product" do
      FarMar::Product.find(1).must_be_instance_of FarMar::Product
    end

    it "should raise an Argument Error if the ID provided isn't in the list" do
      proc { FarMar::Product.find(0) }.must_raise(ArgumentError)
    end
  end

  describe "#vendor" do
    it "should return an instance of vendor" do
      @sale.vendor.must_be_instance_of FarMar::Vendor
    end

    it "should return only one instance, not a collection" do
      @sale.vendor.wont_be_kind_of Hash, Array
    end

    it "should return a vendor_id of 1 with a sale_id of 1" do
      @sale.vendor.id.must_equal 1
    end
  end


end
