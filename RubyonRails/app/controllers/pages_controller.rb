class PagesController < ApplicationController
    before_action :find_current_tenant
    def home
        render :home
    end

    def about
        render :about
    end

    
end
