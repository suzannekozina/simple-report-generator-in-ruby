require 'json'

def setup_files
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
  $products_hash = JSON.parse(file)
	$report_file = File.new("report.txt", "w+")
end

def create_report
	print_sales_report
  print_date
  print_line
  print_products
	print_products_loop
	print_brands
	print_brands_loop
end

def print_sales_report
    $report_file.puts"
           _                                         _
 ___  __ _| | ___  ___     _ __ ___ _ __   ___  _ __| |_
/ __|/ _` | |/ _ \\/ __|   | '__/ _ \\ '_ \\ / _ \| '__| __|
\\__ \\ (_| | |  __/\\__ \\   | | |  __/ |_) | (_) | |  | |_
|___/\\__,_|_|\\___||___/___|_|  \\___| .__/ \\___/|_|   \\__|
                                  |_|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
end
# Print today's date
def print_date
    date = Time.now.strftime("%m/%d/%Y")
    $report_file.puts date
end
def print_line
    $report_file.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
end

def print_products
    $report_file.puts "
									 	 _						_
                    | |          | |
 _ __  _ __ ___   __| |_   _  ___| |_ ___
| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|
| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\
| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/
| |
|_|
	                                 									"
end

def print_products_loop
	$products_hash["items"].each do |toy|
		# Print the name of the toy
		$report_file.puts toy ["title"]
		$report_file.puts "********************************************"
		# Print the retail price of the toy
		$report_file.puts "Retail Price: #{toy["full-price"]}"
		# Calculate and print the total number of purchases
		sales_total = 0
			toy["purchases"].each do |sales|
			sales_total += sales["price"]
    end
		# Calculate and print the average price the toy sold for
		sales_average = []
			toy["purchases"].each do |average|
        sales_average = sales_total / toy["purchases"].length
  	end
  	# Calculate and print the average discount (% or $) based off the average sales price
  	average_discount = []
  		toy["purchases"].each do |discount|
        average_discount = sales_average / toy["full-price"].to_f
  		end
  		$report_file.puts "Total Sales: $#{sales_total}"
  		$report_file.puts "Average Price Paid: $#{sales_average}"
  		$report_file.puts "Average % Discount: #{(100 - average_discount * 100).to_f.round(2)}%"
      $report_file.puts " "
	end
end

# Print "Brands" in ascii art
def print_brands
$report_file.puts "
 _                         _
| |                       | |
| |__  _ __ __ _ _ __   __| |___
| '_ \\| '__/ _` | '_ \\ / _` / __|
| |_) | | | (_| | | | | (_| \\__ \\
|_.__/|_|  \\__,_|_| |_|\\__,_|___/
																		"
end
# For each brand in the data set:
def print_brands_loop
	unique_brands = $products_hash["items"].map { |item| item["brand"] }.uniq
  unique_brands.each_with_index do |brand, index|
    # Print the name of the brand
  	$report_file.puts brand
  	$report_file.puts "********************************************"
  	brands_toys = $products_hash["items"].select {|item| item["brand"] == brand}
  		# Sets the variable value to zero
  		total_stock_brand = 0
  		brand_fullprice_total = 0
  		product_line_total = 0
  		av_brand_price = 0
  		brand_purchases = 0
  		# Count the number of the brand's toys we stock
  		brands_toys.each { |toy| total_stock_brand += toy["stock"].to_i }
  		# Calculate the average price of the brand's toys
  		brands_toys.each { |toy| brand_fullprice_total += toy["full-price"].to_f }
  			product_line_total = brands_toys.map { |toy| toy["brand"] }.length
  			av_brand_price = (brand_fullprice_total / product_line_total).round(2)
  		# Calculate the total sales volume of all the brand's toys combined
  		brands_toys.each do |toy|
  			toy["purchases"].each do |brand_sales|
  			brand_purchases += brand_sales["price"]
  			end
  		end
  # Print the number of the brand's toys we stock
  	$report_file.puts "Number of Products in Stock: #{total_stock_brand}"
  # Print the average price of the brand's toys
  	$report_file.puts "Average Product Price: $#{av_brand_price}"
  # Print the total sales volume of all the brand's toys combined
  	$report_file.puts "Total Sales: $#{brand_purchases.round(2)}"
  	$report_file.puts "
  "
  	end
  end
  def start
    setup_files # load, read, parse, and create the files
    create_report # create the report!
  end
  start # call start method to trigger report generation
