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
      format.json {render text: {"invitee" => JSON.parse(@invitee.to_json(:only => [:id,:name,:family_name,:category, :region, :contact_number], :methods => [:photo_url]))}.to_json}
      format.html {render text: "something"}
    end
  end

  def event_invitee_details
    @invitee = Invitee.find(params[:id])
    event_invitee = @invitee.event_invitees.where(event_id: params[:event_id]).first
    invitee_json = JSON.parse(@invitee.to_json(:only => [:id,:name,:family_name,:category, :region, :contact_number], :methods => [:photo_url]))
    invitee_json[:number_of_people_invited] = event_invitee ? (event_invitee.number_of_people_invited || 0) : 0
    invitee_json[:number_of_people_brought] = event_invitee ? (event_invitee.number_of_people_brought || 0) : 0
    respond_to do |format|
      format.json {render text: {"invitee" => invitee_json}.to_json}
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
        num_people = params[:event_invitee][:number_of_people_invited][i].to_i
        EventInvitee.create!(invitee: @invitee, event_id: event_id, number_of_people_invited: num_people) if num_people > 0
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