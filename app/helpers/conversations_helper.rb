module ConversationsHelper

def participants_name(conversation)

 name = []
 participants = conversation.participants
 if participants.count > 4
 (1..participants.count).each do |user| 	
 unless current_user?(user)
 	name.push(user.name)
 end
 end

name.join(",")
name += "외 <%= participants.count-4 %>명"



else
 participants.each do |user|
 	unless current_user?(user)
 	name.push(user.name)
 	end
end

name.join(",")

end

end

end
