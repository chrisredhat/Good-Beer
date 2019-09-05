require_relative "./spec_helper.rb"

navigation = { 
                "Beer" => "tab-t0-1", 
                "Contact" => "tab-t0-2", 
                "About" => "tab-t0-3",
                "Home" => "tab-t0-0"
              }

beer_button = {
                 "CreateClass" => "android.widget.Button",
                 "InputClass" => "android.widget.EditText",
                 "ImageClass" => "android.widget.Image",
                 "Cancel" => "close",
                 "Submit" => "SAVE"
              }



describe 'Test Case 2 - View Beer' do
  it "View Beer" do
    @drivers.each do |name, driver|
      fork {
        puts "Go to Beer Page - device #{name}"
        driver.find_element(:xpath, "//*[@resource-id=\"#{navigation['Beer']}\"]").click
        beers = driver.find_elements(:class_name, beer_button['ImageClass'])
        beers.each do |beer|
          beer.click
          driver.back
          sleep 3
        end
      }
      Process.wait
    end
    sleep 3
    puts
  end
end
