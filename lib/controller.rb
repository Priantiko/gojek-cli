require_relative './models/user'
require_relative './models/location'
require_relative './models/order'
require_relative './view'

module GoCLI
  # Controller is a class that call corresponding models and methods for every action
  class Controller
    # This is an example how to create a registration method for your controller
    def registration(opts = {})
      # First, we clear everything from the screen
      clear_screen(opts)

      # Second, we call our View and its class method called "registration"
      # Take a look at View class to see what this actually does
      form = View.registration(opts)

      # This is the main logic of this method:
      # - passing input form to an instance of User class (named "user")
      # - invoke ".save!" method to user object
      # TODO: enable saving name and email
      if User.validate(form) == false
         form[:flash_msg] = "hello you are wrong"
        registration(form)
      else
      user = User.new(
        name: form[:name],
        email: form[:email],
        phone:    form[:phone],
        password: form[:password]
      )
      user.save!

      # Assigning form[:user] with user object
      form[:user] = user

      # Returning the form
      form
     end
    end
    
    def login(opts = {})
      halt = false
      while !halt
        clear_screen(opts)
        form = View.login(opts)
        # Check if user inputs the correct credentials in the login form
        if credential_match?(form[:user], form[:login], form[:password])
          halt = true
        else
          form[:flash_msg] = "Wrong login or password combination"
        end
      end

      return form
    end
    
    def main_menu(opts = {})
      clear_screen(opts)
      form = View.main_menu(opts)

      case form[:steps].last[:option].to_i
      when 1
        # Step 4.1
        view_profile(form)
      when 2
        # Step 4.2
        order_goride(form)
      when 3
        # Step 4.3
        View.view_order_history(form)
      when 4
        exit(true)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        main_menu(form)
      end
    end
    
    def view_profile(opts = {})
      clear_screen(opts)
      form = View.view_profile(opts)

      case form[:steps].last[:option].to_i
      when 1
        # Step 4.1.1
        edit_profile(form)
      when 2
        main_menu(form)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        view_profile(form)
      end
    end

    # TODO: Complete edit_profile method
    # This will be invoked when user choose Edit Profile menu in view_profile screen
    def edit_profile(opts = {})
      clear_screen(opts)
      form = View.edit_profile(opts)

      case form[:steps].last[:option].to_i
      # when edit profile
      when 1
         user = User.new(
           name: form[:name],
           email: form[:email],
           phone:    form[:phone],
           password: form[:password]
           )
         user.save!

        # Assigning form[:user] with user object
         form[:user] = user

        # Returning the form
         form
      # when 2 back to view profile
      when 2

        view_profile(form)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        edit_profile(form)
      end
      view_profile(form)
    end

    # TODO: Complete order_goride method
    def order_goride(opts = {})
      arr1 = []
      arr2 = []
      clear_screen(opts)
      form = View.order_goride(opts)
      # puts form
      Location.load.each do |x|
      if x["name"] == form[:place_user]
        arr1 << x["coord"][0]
        arr1 << x["coord"][1]
      end 

      if  x["name"] == form[:des_user]
        arr2 << x["coord"][0]
        arr2 << x["coord"][1]
      end
      end
      if !arr1.empty? && !arr2.empty? 
         form[:flash_msg] = "Your Destination is available"
           sum = Math.sqrt((arr2[0]-arr1[0])**2 + (arr2[1]-arr1[1])**2).to_i
           sum *= 1500
           form[:price] = sum 
          form[:flash_msg] = "Your price is #{sum}"
         order_goride_confirm(form) # Lempar ke pertanyaan pesan, ulangi, exit
       else
        form[:flash_msg] = "Your destination is not available."
       order_goride(opts) #lempar ke pertanyaan pesan, ulangi
        end

      # # def view_order_history(opts = {})
      # form[:result_order1] = arr1
      # form[:result_order2] = arr2
      # form
     end
      # def price(arr1, arr2)
      #   opts[:result_order1]
      # end

    # TODO: Complete order_goride_confirm method
    # This will be invoked after user finishes inputting data in order_goride method
    def order_goride_confirm(opts = {})
      clear_screen(opts)
      form = View.order_goride_confirm(opts)
      

      case form[:steps].last[:option].to_i
      when 1
         order = Order.new(
           des_user: form[:des_user],
           place_user: form[:place_user],
           timestamp: form[Time.new],
           price: form[:price]
           )
         order.save!

        # Assigning form[:user] with user object
        # Returning the form
      when 2
        order_goride(form)
      when 3
        exit(true)
      end

    end

    protected
      # You don't need to modify this 
      def clear_screen(opts = {})
        Gem.win_platform? ? (system "cls") : (system "clear")
        if opts[:flash_msg]
          puts opts[:flash_msg]
          puts ''
          opts[:flash_msg] = nil
        end
      end

      # TODO: credential matching with email or phone
      def credential_match?(user, login, password)
        return false unless user.phone == login || user.email == login
        return false unless user.password == password
        return true
      end
  end
end
