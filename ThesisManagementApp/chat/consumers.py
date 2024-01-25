import json

from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from oauth2_provider.models import AccessToken

from ThesisManagement import serializers
from ThesisManagement.models import *


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope["url_route"]["kwargs"]["room_name"]
        self.room_group_name = f"chat_{self.room_name}"

        # Join room group
        await self.channel_layer.group_add(self.room_group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    # Receive message from WebSocket
    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json["message"]

        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name, {"type": "chat.message", "message": message}
        )

    # Receive message from room group
    async def chat_message(self, event):
        message = event["message"]

        # Send message to WebSocket
        await self.send(text_data=json.dumps({"message": message}))


class Chat1Consumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope["url_route"]["kwargs"]["room_name"]
        self.room_group_name = f"chat_{self.room_name}"

        # Join room group
        await self.channel_layer.group_add(self.room_group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    # Receive message from WebSocket
    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json["message"]
        user_id = self.scope["user"].id  # Get the user ID from the WebSocket scope

        # Save the message to the database
        room = Room.objects.get(name=self.room_name)
        user = User.objects.get(id=user_id)
        Message.objects.create(room=room, text=message, user=user)

        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name, {"type": "chat.message", "message": message}
        )

    # Receive message from room group
    async def chat_message(self, event):
        message = event["message"]

        # Send message to WebSocket
        await self.send(text_data=json.dumps({"message": message}))


class Chat2Consumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.user = await self.get_user(await self.get_user_id_from_token(self.scope)) #1
        self.user_receive_id = self.scope["url_route"]["kwargs"]["userid"]
        self.user_receive = await self.get_user(self.user_receive_id) #2
        user_send = int(self.user.id)
        user_receive = int(self.user_receive_id)
        if user_send < user_receive:
            self.room_name = self.user.username + self.user_receive.username
        else:
            self.room_name = self.user_receive.username + self.user.username
        self.room_group_name = f"chat_{self.room_name}"
        # Join room group
        await self.channel_layer.group_add(self.room_group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    # Receive message from WebSocket
    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json["message"]
        user_id = text_data_json["user_id"]  # Get the user ID from the WebSocket scope
        print(user_id)
        # Save the message to the database
        user = await self.get_user(user_id)
        await self.create_message(message, user)
        print(user.username)
        user_data = await self.get_user_data(user)
        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name, {
                "type": "chat.message",
                "message": message,
                "user": user_data
            }
        )

    # Receive message from room group
    async def chat_message(self, event):
        message = event["message"]
        user_data = await self.get_user_data(self.user)
        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            "message": message,
            "user": user_data
        }))

    @database_sync_to_async
    def get_user_data(self, user):
        return serializers.UserSerializers(user).data

    @database_sync_to_async
    def get_user(self, user_id):
        return User.objects.get(id=user_id)

    @database_sync_to_async
    def create_message(self, message, user):
        return Message.objects.create(text=message, user=user)

    @database_sync_to_async
    def get_user_id_from_token(self, scope):
        query_string = scope.get("query_string", b"").decode("utf-8")
        print(query_string.split('=')[1])
        token_value = query_string.split('=')[1]
        token = AccessToken.objects.get(token=token_value)
        return token.user_id
