# frozen_string_literal: true

require 'faraday'

# Get Detail Tiki Product from link
class TikiProduct
  attr_accessor :product_id

  TIKI_URL = 'https://tiki.vn/api/v2/'

  def initialize(link)
    @conn = Faraday.new(TIKI_URL)
    @product_id = link.slice(/(\d+)\.html/)[0...-5]
  end

  def product_detail
    response = @conn.get "products/#{@product_id}"
    JSON.parse(response.body)
  end

  def review_detail
    response = @conn.get 'reviews/', { product_id: @product_id }
    JSON.parse(response.body)
  end

  def show_product
    product = product_detail
    review = review_detail
    str = "Tên sản phẩm: #{product['name']}\nGiá sản phẩm: #{product['price']} VND\n"
    str << "Tổng lượt đánh giá: #{review['reviews_count']}\nĐánh giá trung bình: #{review['rating_average']}\n"
    str << "-------- 10 lượt đánh giá gần nhất --------\n"
    10.times do |i|
      str << "#{i + 1} : #{review['data'][i]['content']} \n \n"
    end
    str
  end
end
link = 'https://tiki.vn/apple-iphone-14-pro-max-p197216291.html?itm_campaign=tiki-reco_UNK_DT_UNK_UNK_tiki-listing_UNK_p-category-mpid-listing-v1_202305300600_MD_batched_PID.197216298&itm_medium=CPC&itm_source=tiki-reco&spid=197216298'
a = TikiProduct.new(link)
puts a.show_product
