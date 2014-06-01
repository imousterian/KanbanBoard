module OrganizationsHelper

    def update_org_progress(*args)

       key, value = args
       key = key && key.to_s
       if args.size == 1
          progress && progress[key]
       elsif args.size == 2
          raise ArgumentError, "invalid key #{key.inspect}" unless key
          progress_will_change!
          self.progress = (progress || {}).merge(key => value)
          self.progress[key]
       else raise ArgumentError, "wrong number of arguments (#{args.size} for 1 or 2)"
       end

    end

end
