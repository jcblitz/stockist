require 'product_data_retriever'

describe ProductDataRetriever do
  describe "#current_state" do
    it "returns $1,299.00 for a refridgerator from HomeDepot" do
      pdr = ProductDataRetriever.new("http://www.homedepot.com/Appliances-Refrigeration-Refrigerators-Side-by-Side-Refrigerators/h_d1/N-5yc1vZc3q0/R-203203346/h_d2/ProductDisplay?catalogId=10053&langId=-1&storeId=10051&superSkuId=203258504#.UJp5OGl27fg", "#ajaxPrice")
      price = pdr.current_state
      price.content.strip.should eq "$1,299.00"
    end
    it "returns $299.99 from bestbuy" do
      pdr = ProductDataRetriever.new("http://www.bestbuy.com/site/Insignia%26%23153%3B+-+39%26%2334%3B+Class+-+LCD+-+1080p+-+60Hz+-+HDTV/5061732.p;jsessionid=77E4BC3433E38D83E21F9BFA620F8440.bbolsp-app03-06?id=1218609331491&skuId=5061732", ".item-price")
      price = pdr.current_state
      price.content.strip.should eq "$299.99"
    end
    it "returns just text for less specific targets" do
      pdr = ProductDataRetriever.new("http://palmettostatearmory.com/index.php/accessories/magazines/can-o-mags/psa-mags-and-a-bag.html
", ".availability")
      price = pdr.current_state
      price.content.strip.should eq "Availability: TEMPORARILY OUT OF STOCK"
    end
  end
end
