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
                 "Submit" => "Save",
                 "Delete" => "trash Delete"
               }

beer_name = ['Blue Girl', 'City Brew', 'Smooth Hoperator', 'Hoptimus Prime', 'Even More Jesus'] 

describe 'Test Case 3 - Delete Beer' do
  it "Delete Beer" do
    @drivers.each do |name, driver|
        puts "Go to Beer Page - device #{name}"
        driver.find_element(:accessibility_id, navigation["Beer"]).click
        puts "Flick Beer - device #{name}"
        beer = driver.find_element(:xpath, "//*[@type='XCUIElementTypeStaticText'][@name='Blue']")
        driver.execute_script("mobile: swipe", { "direction" => "left", "element" => beer })
        puts "Delete Beer - device #{name}"
        #driver.find_element(:accessibility_id, beer_button["Delete"]).click
    end
    sleep 2
    puts
  end
end

