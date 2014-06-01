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

    def update_your_org(k)
    #     if self.progress.keys != this_kanban.settings.keys
    #         diff = self.progress.keys
    #     end

        orgs = k.organizations
        orgs.each do |org|
            logger.debug " #{org.progress.keys} "
            logger.debug " #{k.settings.keys} "
            if org.progress.keys != k.settings.keys
                diff = k.settings.keys - org.progress.keys
                org.progress[:diff] = 'test'
                # org.progress = k.settings
                org.save
            end
        end
    end



    # def column_generator
    #     # arr = Array.new
    #     # arr.push(name)
    #     # settings.each { |i| arr.push i.keys }
    #     # arr.push (settings.keys)
    #     # return arr.flatten
    #     return settings.keys
    # end

end
