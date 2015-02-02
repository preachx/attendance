class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @event_invitees = EventInvitee.where(event: @event).includes(:invitee)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(secure_params)
      redirect_to :event_path, :notice => "Event updated"
    else
      redirect_to :event_path, :alert => "Unable to update invitee"
    end
  end

  private

  def secure_params
    params.require(:invitee).permit(:name, :family_name, :region, :category, :contact_number)
    params.require(:events).permit(:event_date, :description)
    params.require(:event_invitee).permit(:number_of_people_brought, :number_of_people_invited)
  end

end