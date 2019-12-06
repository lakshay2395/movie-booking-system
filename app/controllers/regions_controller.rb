class RegionsController < ApplicationController

    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_region }, only: [:show, :destroy, :update] 
    before_action -> { update_region_details_before_save }, only: [:update]

    REGION_NOT_FOUND = 'No region found for id %s'.freeze

    def index
        render json: @regions, status: :ok
    end

    def show
        if @region
            render json: @region, status: :ok
        else
            handle_error(REGION_NOT_FOUND % [id],:not_found)
        end
    end

    def create
       region = Region.new(name: name, region_type: region_type, parent: parent) 
       if region.valid?
            region.save!
            render json: region, status: :created
       else
            handle_error(region.errors.messages,:internal_server_error)
       end
    end

    def destroy
        if @region
            @region.destroy!
            render json: nil, status: :no_content
        else
            handle_error(REGION_NOT_FOUND % [id],:not_found)
        end
    end 

    def update
        if @region.valid?
            @region.save!
            render json: @region, status: :ok
        else 
            handle_error(@region.errors.messages,:internal_server_error)
        end
    end

    private

    def id 
        params[:id]
    end
    
    def name
        params[:name]
    end

    def region_type
        params[:region_type]
    end

    def parent
        Region.find_by(id: parent_id)
    end

    def parent_id
        params[:parent_id]
    end

    def fetch_region
        @region = Region.find_by(id: id)
    end

    def fetch_all
        @regions = Region.all
    end

    def update_region_details_before_save
        @region.name = name
        @region.region_type = region_type
        @region.parent = parent
    end
    
end