module Api
    module V1
        class OrdersController < ApplicationController 
            def index 
                if customer_id
                    @orders = Order.where(customer_id: params[:customer_id])
                else
                    @orders = Order.all 
                end

                render json: @orders 
            end

            def show 
                @order = Order.find(params[:id])

                render json: @order 
            end

            def create 
                @order = Order.new(user_params)
                @order.save!
                user_params["status"] = "pending"

                render json: @order 
            end

            def ship
                @order = Order.find(params[:id])
                @order.update!({status: "shipped"})
                
                render json: @order 
            end
        end
    end
end