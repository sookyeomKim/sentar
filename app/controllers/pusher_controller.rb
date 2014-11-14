require 'pusher'

Pusher.app_id = '96416'
Pusher.key = 'a49249ec2328f5c4474d'
Pusher.secret = '247615e156ccedebb1f2'




class PusherController < ApplicationController


protect_from_forgery :except => :auth # stop rails CSRF protection for this action



def test
Pusher["presence-sentar"].trigger("test-event", {:id => current_user.id })
render :text => "test pusher"
end

# def auth
# response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
# render :json => response
# end




def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id, # => required
        :user_info => { # => optional - for example
          :name => current_user.name,
          :email => current_user.email
        }
      })
      render :json => response
    else
      render :text => "Forbidden", :status => '403'
    end
  end

  
end