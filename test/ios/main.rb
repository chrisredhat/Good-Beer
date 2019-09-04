require_relative "./spec_helper.rb"

navigation = {  
                "Beer" => "beer outline Beer",
                "Contact" => "contacts outline Contact",
                "About" => "information circle-outline About",
                "Home" => "home outline Home"
              }

beer_button = {
                 "Create" => "add circle beer",
                 "InputClass" => "XCUIElementTypeTextField",
                 "Submit" => "Save"
               }

describe 'Test Case 1 - Tap Page Icon on Navigation Bar' do
  
  navigation.each do |page, id|
    it "Go to #{page} Page" do
      puts "Go to #{page} Page"     
      @drivers.each do |name, driver|
        fork {
          puts "Go to #{page} on device #{name}"
          driver.find_element(:accessibility_id, id).click 
          puts "Pass !"
        }
        Process.wait
      end
      sleep 1 
      puts
    end
  end
end

describe 'Test Case 2 - Create Beer' do
  it "Create Beer" do
    @drivers.each do |name, driver|
      fork {
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        beer_name = (0...6).map { o[rand(o.length)] }.join

        puts "Go to Beer Page - device #{name}"
        driver.find_element(:accessibility_id, navigation["Beer"]).click
        puts "Tap create button - device #{name}"
        driver.find_element(:accessibility_id, beer_button["Create"]).click
        puts "Input Beer Name - device #{name}"
        driver.find_element(:class_name, beer_button["InputClass"]).send_keys(beer_name)
        puts "Save New Beer - device #{name}"
        driver.find_element(:accessibility_id, beer_button["Submit"]).click
      }
      Process.wait
    end
    sleep 3
    puts
  end
end

