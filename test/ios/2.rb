require_relative "./spec_helper.rb"

navigation = {
                "Beer" => "beer outline Beer",
                "Contact" => "contacts outline Contact",
                "About" => "information circle-outline About",
                "Home" => "home Home"
              }

beer_button = {
                 "Create" => "add circle beer",
                 "Class" => "XCUIElementTypeTextField", 
                 "Submit" => "Save"
               }

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
        driver.find_element(:class_name, beer_button["Class"]).send_keys(beer_name)
        puts "Save New Beer - device #{name}"
        driver.find_element(:accessibility_id, beer_button["Submit"]).click
      }
      Process.wait
    end
    sleep 2
    puts
  end
end

