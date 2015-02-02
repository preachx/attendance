class EventsController < ApplicationController
  respond_to :json,:html

  def index
    @events = Event.all
  end

  def get_all
    respond_with Event.all
  end

  def search
    event = Event.find(params[:event_id])
    hash = {}
    hash[:category] = params[:category] if params[:category]
    where_condition = []
    [:name, :family_name, :region].each do |param|
      where_condition << " #{param} like '%#{params[param]}%' " if params[param]
    end
    respond_with event.invitees.where(hash).where(where_condition.join(" and "))
  end

  def update_invitee_people_count
    event = Event.find(params[:event_id])
    invitee = Invitee.find(params[:invitee_id])
    event_invitee = EventInvitee.where(event: event, invitee: invitee).first
    event_invitee.update_attribute(:number_of_people_brought, params[:number_of_people_brought])
    respond_with event_invitee
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