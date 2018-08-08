class Application

  @@items = ["Apples","Carrots","Pears"]
  @@items = []

  def call(env)
    resp = Rack::Response.new

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty\n"
      else @@cart.each {|item| resp.write "#{item}\n"}
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add
        @@cart << item_to_add
        resp.write "We added #{{item_to_add} to the cart}"
    else
      resp.write "We don't have that item"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
