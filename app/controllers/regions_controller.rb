class RegionsController < ApplicationController

    before_action -> { fetch_all }, only: [:index]
    before_action -> { fetch_region }, only: [:show, :destroy, :update] 
    before_action -> { update_region_details_before_save }, only: [:update]

    REGION_NOT_FOUND = 'No region found for id %s'.freeze

    def index
        index_model(@regions)
    end

    def show
        show_model(@region,REGION_NOT_FOUND % [id],:not_found)
    end

    def create
       region = Region.new(name: name, region_type: region_type, parent: parent) 
       create_or_update_model(region)
    end

    def destroy
        destroy_model(@region,REGION_NOT_FOUND % [id],:not_found)
    end 

    def update
        create_or_update_model(@region)
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