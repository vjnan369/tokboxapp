class GroupsController < ApplicationController
	require "opentok"
	before_filter :config_opentok
  def index
  	@group = Group.new
  	@groups = Group.all
  end

  def create
  	session = @opentok.create_session :media_mode => :routed
  	params[:group][:sessionId] = session.session_id
  	Group.create(strong_param)
  	#@group = Group.new(params[:group])
  
  end

  def room
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
