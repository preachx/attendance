class EventsController < ApplicationController
  respond_to :json,:html

  def index
    @events = Event.all
  end

  def get_all
    respond_with Event.all
  end

  def search
    Time.zone = "Mumbai"
    event = Event.where(event_date: Time.zone.now.to_date).first
    event ? respond_with({event: event, invitees: event.invitees}) : respond_with({})
  end
  #
  # def advanced_search
  #   search_string = params[:search_string];
  #   @event = Event.find(params[:event][:id])
  #   @event_invitees = EventInvitee.where(event: @event).joins(:invitee).includes(:invitee).where("name like '%#{search_string}%'")
  #   render event_path
  # end

  def update_invitee_people_count
    @event = Event.find(params[:event_id])
    invitee = Invitee.find(params[:invitee_id])
    event_invitee = EventInvitee.where(event: @event, invitee: invitee).first
    event_invitee.update_attribute(:number_of_people_brought, params[:number_of_people_brought])
    @id = params[:event_id]
    respond_to do |format|
      format.json {render text: {"eventInvitee" => event_invitee}.to_json}
      format.html {redirect_to event_path(id: params[:event_id]), notice: "Updated Successfully"}
    end
  end

  def show
    @event = Event.find(params[:id])
    eis = EventInvitee.where(event: @event).joins(:invitee).includes(:invitee)
    eis = eis.where("name like '%#{params[:invitee][:search_string]}%'") if params[:invitee] && params[:invitee][:search_string]
    @event_invitees = eis.order(:id)

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