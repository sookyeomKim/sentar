require 'pusher'

Pusher.app_id = '96197'
Pusher.key = '272fd5c5d1a8969702f3'
Pusher.secret = '9fbd4d50a76ceb7dd04b'




class PusherController < ApplicationController


protect_from_forgery :except => :auth # stop rails CSRF protection for this action



def test
Pusher["sentar_channel"].trigger("sentar-event", {:message => "test"})
render :text => "test pusher"
end

def auth
response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
render :json => response
end

end