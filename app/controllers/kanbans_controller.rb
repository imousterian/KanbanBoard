class KanbansController < ApplicationController
    include KanbansHelper


    def index
        @kanbans = Kanban.all
        # @kanbans = Kanban.order(:created_at => :desc)
    end

    def new
        @kanban = Kanban.new

    end

    def edit
        @kanban = Kanban.find(params[:id])
    end

    def show

        session[:current_kanban] = Hash.new
        @kanban = Kanban.find(params[:id])
        session[:current_kanban] = @kanban

    end


    def default
        @kanban = Kanban.new
        @kanban.name = "Rename me! Kanban # " + (Kanban.count + 1).to_s

        # logger.debug " count #{Kanban.count}"
        # @kanban.kanban_milestones.build
        # 1.upto(2) do |i|

        #     # @kanban.columnholder = "col_" + i.to_s
        #     # @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        # end

        @kanban.save

        @kanban.create_kanban_milestone(@kanban.id)

        redirect_to kanbans_path
    end

    def create

        @kanban = Kanban.new(kanban_params)
        @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        if @kanban.save
            flash[:success] = "Welcome to the Kanban App!"
            redirect_to kanbans_path
        else
            render '/kanbans/new'
        end

    end

    # def delete
    #     @kanban = Kanban.find(params[:id])
    #     # @kanban.destroy(params[:to_delete])
    #     # @kanban.destroy
    #     @kanban[:settings].delete(params[:to_delete])
    #     logger.debug " test #{ @kanban[params[:to_delete]] }"
    #     # redirect_to kanbans_path(@kanban)
    #     # params[:user][:membership_attributes].delete(:"expiration_date(3i)")
    # end

    def update

        @kanban = Kanban.find(params[:id])

        if @kanban.update_attributes(kanban_params)

            if params[:commit] == 'Save'
                @kanban.progress_settings(@kanban.create_key_name, @kanban.columnholder)
                @kanban.columnholder = nil
            end

            if params[:remove_columns]
                if !params[:cols].empty?
                    key_to_delete = params[:cols]
                    key_to_delete.each_key do |k|

                        @kanban.delete_from_hstore(k)

                        @kanban.organizations.each do |org|
                            org.org_delete_from_hstore(k)
                        end
                    end
                end
            end

            update_your_org(@kanban)

            @kanban.save

            redirect_to @kanban

        else
            flash[:error] = "boo"
            redirect_to kanbans_path
        end

    end

    private
        def kanban_params
            # params.require(:kanban).permit! #(:name, :columnholder, :settings)
            # params.require(:kanban).permit(:settings, :name, :columnholder)
            params.require(:kanban).permit(:name)

        end

end
