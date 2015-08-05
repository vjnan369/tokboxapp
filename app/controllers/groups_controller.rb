class GroupsController < ApplicationController
	require "opentok"
	before_filter :config_opentok
  def index
    session = nil;
  	@group = Group.new
  	@groups = Group.all
  end

  def create
  	session = @opentok.create_session :media_mode => :routed
  	params[:group][:sessionId] = session.session_id
  	@group = Group.create(strong_param)
  	#@group = Group.new(params[:group])
    if @group.save
      redirect_to("/room/"+@group.id.to_s)
    else
      render :controller => 'groups', :action => 'index'
    end
  
  end

  def room
    @group = Group.find(params[:id])
    role = :moderator
    @opentok_token = @opentok.generate_token @group.sessionId
  end
private
  def config_opentok
  	if @opentok.nil?
  		@opentok = OpenTok::OpenTok.new 45297362, "df0ccc74f4392e9bea2899d8c8535beab569dd62"
  	end
  end
  def strong_param
  		params.require(:group).permit(:name,:sessionId)
  end
end
