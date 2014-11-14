require 'pusher'

Pusher.app_id = '96507'
Pusher.key = '02d90faab8b070521a56'
Pusher.secret = 'cd2a54b829853d9fec6c'




class PusherController < ApplicationController


protect_from_forgery :except => :auth # stop rails CSRF protection for this action



def test
Pusher["presence-sentar"].trigger("pusher:member_added", {:type => "new_purchase"})
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