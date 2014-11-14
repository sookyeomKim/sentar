




class PusherController < ApplicationController


protect_from_forgery :except => :auth # stop rails CSRF protection for this action



def test
Pusher["mychannel-#{current_user.id}"].trigger("my-event", {:type => "new_purchase"})
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