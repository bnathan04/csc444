class InteractionsController < ApplicationController
    def index
    end

    def update
    end

    def edit
    end

    def show
    end

    def new
    end

    def create
        logger.debug "Creating a new Interaction......"
        logger.debug params
        request_type = params[:interaction][:request_type]
        if request_type == "0"
            logger.debug "Creating a request......"
            request_item
        elsif request_type == "1"
            logger.debug "Creating an approval......"
            approve_request
        elsif request_type == "2"
            logger.debug "Creating a return......"
            return_item
        end
    end

    def destroy
    end

    ##############################################
    ##############PRIVATE FUNCTIONS###############
    ##############################################
    private

    def interaction_params
        params.require(:interaction).permit(:person_id,
                                            :item_id,
                                            :end_date,
                                            :start_date,
                                            :request_type)
    end

    def find_most_recent_approved_interaction
        interaction_with_item = Interaction.where(item_id: @item.id).order("date")
        interaction_with_item_approved = interaction_with_item.where(status: :approved)
        last_approved_interaction = interaction_with_item_approved.last
        return last_approved_interaction
    end

    def request_item
        @person = Person.find_by_user_id(current_user.id)
        @item   = Item.find(params[:item_id])
        form_params = interaction_params
        logger.debug form_params
        input_params = {:person_id => @person.id, :date => DateTime.now,
                        :status => :requested,
                        :start_date => form_params[:start_date],
                        :end_date => form_params[:end_date]}
        logger.debug "trying to save interaction......"
        @interaction = @item.interactions.create(input_params)
        if @interaction.save
            logger.debug "Interation Successfully saved......"
            logger.debug "number of interactions: "
            logger.debug Interaction.all.count
            redirect_to @item
        else
            logger.debug "Interation unsuccessfully saved......"
            #set valid transaction to true when re-rendering the view to show the
            #form again
            @valid_interaction = true
            render "/items/show"
        end
    end

    def approve_request
        #logger.debug "approval parameters:"
        #logger.debug params
        form_params = interaction_params
        @item       = Item.find(params[:item_id])
        input_params = {:person_id => form_params[:person_id],
                        :date => DateTime.now, :status => :approved,
                        :start_date => form_params[:start_date],
                        :end_date => form_params[:end_date]}
        #debugging purposes
        logger.debug "number of interactions before approval: "
        logger.debug Interaction.all.count
        @interaction = @item.interactions.create(input_params)
        @item.update(current_holder: form_params[:person_id])
        logger.debug "number of interactions after approval: "
        logger.debug Interaction.all.count

        redirect_to homepage_notifications_path
    end

    def return_item
        @item      = Item.find(params[:item_id])
        approved_interaction = find_most_recent_approved_interaction
        start_date = approved_interaction.start_date
        end_date   = approved_interaction.end_date
        interaction_params = {:person_id => @person.id, :date => DateTime.now,
                              :status => :returned, :start_date => start_date,
                              :end_date => end_date}

        @interaction = @item.interactions.create(interaction_params)

        if @interaction.save
            logger.debug "Successful return"
            @item.update(current_holder: "")
        else
            logger.debug "Return failed"
        end
        redirect_to @item
    end

end