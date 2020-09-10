class FoodsController < ApplicationController

    def index 
        @foods = Food.all 
    end 

    def show
        @food = Food.find_by_id(params[:id])
    end 

    def new 
        @food = Food.new 
    end 

    def create

    end 

    def edit

    end 

    def update

    end 

    def destroy 

    end 
end
