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
                 "Submit" => "SAVE"
              }



describe 'Test Case 2 - Create Beer' do
  it "Create Beer" do
    @drivers.each do |name, driver|
      fork {
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        beer_name = (0...6).map { o[rand(o.length)] }.join
        
        puts "Go to Beer Page - device #{name}"
        driver.find_element(:xpath, "//*[@resource-id=\"#{navigation['Beer']}\"]").click
        puts "Tap create button - device #{name}"
        driver.find_element(:class_name, beer_button["CreateClass"]).click
        puts "Input Beer Name - device #{name}"
        driver.find_element(:class_name, beer_button["InputClass"]).send_keys(beer_name)
        puts "Save New Beer - device #{name}"
        driver.find_element(:xpath, "//*[@text=\"#{beer_button['Submit']}\"]").click
      }
      Process.wait
    end
    sleep 5
    puts
  end
end
