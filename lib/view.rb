module GoCLI
  # View is a class that show menus and forms to the screen
  class View
    # This is a class method called ".registration"
    # It receives one argument, opts with default value of empty hash
    # TODO: prompt user to input name and email
    def self.registration(opts = {})
      form = opts

      puts 'Registration'
      puts ''

      print 'Your name :'
      form[:name] = gets.chomp

      print 'Your Email :'
      form[:email] = gets.chomp

      print 'Your phone: '
      form[:phone] = gets.chomp

      print 'Your password: '
      form[:password] = gets.chomp

      form[:steps] << {id: __method__}

      form
    end

    def self.login(opts = {})
      form = opts

      puts 'Login'
      puts ''

      print 'Enter your login: '
      form[:login] = gets.chomp

      print 'Enter your password: '
      form[:password] = gets.chomp

      form[:steps] << {id: __method__}

      form
    end

    def self.main_menu(opts = {})
      form = opts

      puts 'Welcome to Go-CLI!'
      puts ''

      puts 'Main Menu'
      puts '1. View Profile'
      puts '2. Order Go-Ride'
      puts '3. View Order History'
      puts '4. Exit'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}

      form
    end

    # TODO: Complete view_profile method
    def self.view_profile(opts = {})
      form = opts

      

      # Show user data here
      puts "Your Data"
      puts ''
      puts "Nama : #{form[:user].name}"
      puts "Email : #{form[:user].email}"
      puts "Phone : #{form[:user].phone}"
      puts "Password : #{form[:user].password}"
      puts ''
      puts 'Do you want to :'
      puts ''

      puts '1. Edit Profile'
      puts '2. Back'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}

      form
    end

    # TODO: Complete edit_profile method
    # This is invoked if user chooses Edit Profile menu when viewing profile
    def self.edit_profile(opts = {})
      form = opts

      puts 'Edit Profile'
      puts ''

      print 'Your name :'
      form[:name] = gets.chomp

      print 'Your Email :'
      form[:email] = gets.chomp

      print 'Your phone: '
      form[:phone] = gets.chomp

      print 'Your password: '
      form[:password] = gets.chomp
      puts ''

      puts 'What do u want'

      puts '1. Save'
      puts '2. Discard'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}

      form



    end

    # TODO: Complete order_goride method
    def self.order_goride(opts = {})
      form = opts

      puts 'Where are you ?'
      form[:place_user] = gets.chomp

      puts 'Your Destination'
      form[:des_user] = gets.chomp

      form[:steps] << {id:__method__}
      form

    end

    # TODO: Complete order_goride_confirm method
    # This is invoked after user finishes inputting data in order_goride method
    def self.order_goride_confirm(opts = {})
      form = opts

      puts '1. Order'
      puts '2. Try again'
      puts '3. exit'

      puts 'Enter your option'
      form[:steps]<<{id:__method__, option:gets.chomp}

      form
    end

    # TODO: Complete view_order_history method
    def self.view_order_history(opts = {})

      a = Order.load_all
      a.each do |x|
            puts ''
           puts "Time        : #{x['timestamp']}"
           puts "Destination : #{x['des_user']}"
           puts "origin      : #{x['place_user']}"
           puts "price       : #{x['price']}"
       end      
    end
  end
end
