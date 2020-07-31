class ProductWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    # p 'Hello World!'
    Product.all.each do |p|
      if p.last_bidding_date < DateTime.now() 
        user = p.user
        p.update_attributes(status: 'sold')
        p.bid.update_attributes(status: 'sold')
      end
    end
  end
end
