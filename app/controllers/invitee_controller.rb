class InviteeController < ApplicationController

  respond_to :json, :html

  def new
    @invitee = Invitee.new
    @events = Event.all
  end

  def index
    @invitees = Invitee.all
  end

  def show
    @invitee = Invitee.find(params[:id])
    respond_to do |format|
      format.json {render text: @invitee.to_json(:only => [:id,:name,:family_name,:category, :region, :contact_number], :methods => [:photo_url])}
      format.html {render text: "something"}
    end

  end

  def update
    @invitee = Invitee.find(params[:id])
    if @invitee.update_attributes(secure_params)
      redirect_to :invitee_path, :notice => "Invitee updated"
    else
      redirect_to :invitee_path, :alert => "Unable to update invitee"
    end
  end

  def create
    Invitee.transaction do
      @invitee = Invitee.create!( secure_invitee_params )
      params[:event_invitee][:event_id].each_with_index do |event_id, i|
        EventInvitee.create!(invitee: @invitee, event_id: event_id, number_of_people_invited: params[:event_invitee][:number_of_people_invited][i])
      end
    end
    redirect_to :new_invitee, :notice => "Created invitee"
  end

  private

  def secure_invitee_params
    params.require(:invitee).permit(:name, :family_name, :region, :category, :contact_number, :photo)
    #params.require(:events).permit(:event_date, :description)
  end

end