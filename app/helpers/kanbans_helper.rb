module KanbansHelper

    def progress_settings (*args)

        # borrowed from
        # http://www.artandlogic.com/blog/2012/09/custom-fields-in-rails/

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

        orgs = k.organizations
        orgs.each do |org|
            if org.progress.keys != k.settings.keys
                diff = k.settings.keys - org.progress.keys
                # logger.debug " diff #{diff}"

                value = diff[0]
                # hash = { 'value' => value }

                # org.progress = org.progress.merge(hash)
                org.update_org_progress(value, '--')
            else
                # logger.debug " create tests "
                # org.progress = k.settings

            end
            org.save
        end
    end

    def create_key_name
        name = 'col_' + (settings.count + 1).to_s
    end

end
