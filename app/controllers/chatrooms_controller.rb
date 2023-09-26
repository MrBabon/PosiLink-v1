class ChatroomsController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:query].present?
            @chatrooms = Chatroom.joins(participants: :user).where.not(participants: { user: current_user }).where("users.nickname ILIKE ?", "%#{params[:query]}%")
        else
            @chatrooms = current_user.chatrooms.includes(:messages)
        end
        params[:query] = ""
    end

    def show
        @chatroom = Chatroom.find(params[:id])
        if @chatroom.private && !@chatroom.users.include?(current_user)
            redirect_to chatrooms_path, notice: "Vous avez pas accés à cette conversation"
        else
            @messages = @chatroom.messages.order(created_at: :asc)
        end
    end

    def new_private_conversation
        @users = User.where.not(id: current_user.id) # Exclure l'utilisateur actuel de la liste
        @chatroom = Chatroom.new
    end

    def chatroom_partial
    @chatroom = Chatroom.find(params[:id])
    render partial: "chatroom", locals: { chatroom: @chatroom }
    end

    def create_private_conversation
        # Créez une nouvelle chatroom pour la conversation privée
        chatroom = Chatroom.create

        # Associez les utilisateurs à la conversation privée via la table participants
        chatroom.participants.create(user: current_user)
        other_user = User.find(params[:other_user_id])
        chatroom.participants.create(user: other_user)
      
        # Redirigez l'utilisateur vers la conversation privée nouvellement créée
        redirect_to chatroom_path(chatroom)
      end
end
