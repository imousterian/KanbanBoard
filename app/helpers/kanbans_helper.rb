module KanbansHelper

    def progress_settings (*args)

       key, value = args
       key = key && key.to_s
       if args.size == 1
          settings && settings[key]
       elsif args.size == 2
          raise ArgumentError, "invalid key #{key.inspect}" unless key
          settings_will_change!
          self.settings = (settings || {}).merge(key => value)
          self.settings[key]
       else raise ArgumentError, "wrong number of arguments (#{args.size} for 1 or 2)"
       end

    end

    def column_generator
        # arr = Array.new
        # arr.push(name)
        # settings.each { |i| arr.push i.keys }
        # arr.push (settings.keys)
        # return arr.flatten
        return settings.keys
    end

end