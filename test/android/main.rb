require_relative "./spec_helper.rb"

navigation = { 
                "Beer" => "tab-t0-1", 
                "Contact" => "tab-t0-2", 
                "About" => "tab-t0-3",
                "Home" => "tab-t0-0"
              }

beer_button = {
                 "Create" => "add circle beer",
                 "InputClass" => "android.widget.EditText",
                 "Submit" => "Save"
              }



describe 'Test Case 1 - Tap Page Icon on Navigation Bar' do

  navigation.each do |page, id|
    it "Go to #{page} Page" do
      puts "Go to #{page} Page"     
      @drivers.each do |name, driver|
        fork {
          puts "Go to #{page} on device #{name}"
          driver.find_element(:xpath, "//*[@resource-id=\"#{id}\"]").click 
          puts "Pass !"
        }
        Process.wait
      end
      sleep 1 
      puts
    end
  end
end


