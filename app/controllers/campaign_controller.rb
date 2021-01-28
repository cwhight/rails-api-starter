require_relative './concerns/response'

class CampaignController < ApplicationController
  before_action :set_campaign, only: [:show, :update, :destroy]

  def index
    @campaigns = Campaign.all
    json_response(@campaigns)
  end

  def show
    json_response(@campaign)
  end

  def create
    @campaign = Campaign.create!(campaign_params)
    json_response(@campaign, :created)
  end

  # PUT /todos/:id
  def update
    @campaign.update(campaign_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @campaign.destroy
    head :no_content
  end

  private
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.permit(:first_name, :last_name, :description, :bio)
  end
end
