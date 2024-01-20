import json

from asgiref.sync import async_to_sync
from channels.db import database_sync_to_async
from channels.generic.websocket import JsonWebsocketConsumer
from channels.layers import get_channel_layer
from djangochannelsrestframework.generics import GenericAsyncAPIConsumer
from djangochannelsrestframework.observer import model_observer
from djangochannelsrestframework.observer.generics import ObserverModelInstanceMixin, action
from oauth2_provider.models import AccessToken
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q

from .models import Message, Room, User
from .serializers import MessageSerializer, RoomSerializer, UserSerializers
# consumers.py
import json
from channels.generic.websocket import AsyncWebsocketConsumer
from .models import Message, Room, User


class ChatConsumer(AsyncWebsocketConsumer):
    @database_sync_to_async
    def get_user_id_from_token(self, scope):
        query_string = scope.get("query_string", b"").decode("utf-8")
        print(query_string.split('=')[1])
        token_value = query_string.split('=')[1]
        token = AccessToken.objects.get(token=token_value)
        return token.user_id

    # async def connect(self):
    #     user_id = await self.get_user_id_from_token(self.scope)
    #     self.user = await self.get_user_id(user_id)
    #     # self.id_user_2 = (await self.get_user_id(user_id)).id #người muốn nhắn
    #     # self.user2 = await self.get_user_id(self.id_user_2)
    #     # print("user " + self.user2.username + " kết nối đến websocket!")
    #     self.receive_id = self.scope['url_route']['kwargs']['id_user']
    #     self.receive_user = await self.get_user_id(self.receive_id)
    #     room = await self.get_room()
    #     self.channel_name = self.user.username
    #     self.room_group_name = room.name
    #     # async_to_sync(self.channel_layer.group_add)()
    #     await self.channel_layer.group_add(
    #         self.room_group_name,
    #         self.channel_name
    #     )
    #     channel_layer = get_channel_layer()
    #     await self.channel_layer.send(self.room_group_name, {
    #         "type": "chat.message",
    #         "text": "Hello there!",
    #     })
    #     # await self.channel_layer.group_add(
    #     #
    #     # )
    #     # self.user1 = await self.get_user_id(self.id_user_1)
    #     # self.room = await self.get_or_create_room_for_user() # host
    #     # # print("user: " + self.user.username + " kết nối tới room: " + self.room_name + " thành công!")
    #     # self.channel_name = self.user2.username
    #     # print('Tới đây')
    #     # # Thêm người dùng mới vào nhóm phòng
    #     # await self.channel_layer.group_add(
    #     #     str(self.room.id),
    #     #     self.channel_name
    #     # )
    #     # #=============================================================
    #     #
    #     # print('Thêm người dùng thành công!')
    #     # # print(self.room_id)
    #     # # print(self.channel_name)
    #     # # # Gửi thông báo cho toàn bộ người dùng trong phòng về sự kiện tham gia mới
    #     # await self.channel_layer.group_send(
    #     #     str(self.room.id),
    #     #     {
    #     #         'type': 'user.join',
    #     #         'user_id': self.user2.id,
    #     #     }
    #     # )
    #
    #     await self.accept()
    #     await self.send(text_data=json.dumps({
    #         'message': 'connect successful',
    #         'user_id': self.user.id,
    #     }))
    #
    #     self.channel_layer.send(self.room_group_name, {
    #         "type": "chat.message",
    #         "text": "connect successful! hi",
    #     })
    async def connect(self):
        user_id = await self.get_user_id_from_token(self.scope)
        self.user = await self.get_user_id(user_id)
        self.receive_id = self.scope['url_route']['kwargs']['id_user']
        self.receive_user = await self.get_user_id(self.receive_id)
        room = await self.get_room()
        # self.channel_name = self.user.username
        self.room_group_name = room.name

        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        # Send a message after connecting
        await self.channel_layer.send(
            self.room_group_name,
            {
                "type": "chat.message",
                "text": "connect successful! hi",
            }
        )

        await self.accept()
        print('user connect ' + self.user.username)
        await self.send(text_data=json.dumps({
            'message': 'connect successful',
            'user_id': self.user.id,
        }))

    @database_sync_to_async
    def get_room(self):
        room_name1 = self.user.username + '_' + self.receive_user.username
        room_name2 = self.receive_user.username + '_' + self.user.username
        try:
            room = Room.objects.get(name=room_name1)
        except ObjectDoesNotExist:
            try:
                room = Room.objects.get(name=room_name2)
            except ObjectDoesNotExist:
                room = Room.objects.create(name=room_name1, host=self.user)
        return room

    @database_sync_to_async
    def get_room_id(self, user):
        return Room.objects.get(name=user.username).id

    @database_sync_to_async
    def get_room_user1_2(self):
        return Room.objects.filter(Q(current_users=self.user1) | Q(host=self.user2))

    @database_sync_to_async
    def get_room_name_id(self, room_name):
        try:
            room = Room.objects.get(name=room_name)
        except ObjectDoesNotExist:
            room = Room.objects.get_or_create(name=room_name)
        return room.id, room.name

    @database_sync_to_async
    def get_user_id(self, user_id):
        return User.objects.get(pk=user_id)

    @database_sync_to_async
    def get_user_username(self, username):
        return User.objects.get(username=username)

    @database_sync_to_async
    def get_or_create_room_for_user(self):
        room, created = Room.objects.get_or_create(name=self.user2.username, host=self.user2)
        room.current_users.add(self.user1, self.user2)
        room.save()
        return room

    @database_sync_to_async
    def save_message(self, room_id, user, message):
        room = Room.objects.get(pk=room_id)
        Message.objects.create(room=room, text=message, user=user)

    async def disconnect(self, close_code):
        # Leave room
        print("user rời khỏi")

    async def receive(self, text_data):
        data = json.loads(text_data)
        message = data['message']
        user_id = data['user_id']
        # receiver_id = data['receiver_id']


        # Get user object
        user = self.get_user_id(user_id)
        print(user_id + 'đã gửi một gói tin')
        print(message)
        user = await self.get_user_id(user_id)
        room = await self.get_room()

        # await self.channel_layer.group_send(
        #     str(self.room.id),
        #     {
        #         'type': 'user.join',
        #         'user_id': self.user2.id,
        #     }
        # )

        await self.save_message(room.id, user, message)

        await self.send_chat_message(room.name, message, user_id)

    async def send_chat_message(self, room_id, message, user_id):
        # Gửi tin nhắn đến WebSocket
        await self.send(text_data=json.dumps({
            'message': message,
            'user_id': user_id,
        }))

        await self.channel_layer.send(
            self.room_group_name,
            {
                "type": "chat.message",
                "text": message,
            }
        )

    async def chat_message(self, event):
        message = event['message']
        user_id = event['user_id']
        print('chat message đang chạy!')

        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            'message': message,
            'user_id': user_id,
        }))


class RoomConsumer(ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    lookup_field = "pk"

    async def disconnect(self, code):
        if hasattr(self, "room_subscribe"):
            await self.remove_user_from_room(self.room_subscribe)
            await self.notify_users()
        await super().disconnect(code)

    @action()
    async def join_room(self, pk, **kwargs):
        self.room_subscribe = pk
        await self.add_user_to_room(pk)
        await self.notify_users()

    @action()
    async def leave_room(self, pk, **kwargs):
        await self.remove_user_from_room(pk)

    @action()
    async def create_message(self, message, **kwargs):
        room: Room = await self.get_room(pk=self.room_subscribe)
        await database_sync_to_async(Message.objects.create)(
            room=room,
            user=self.scope["user"],
            text=message
        )

    @action()
    async def subscribe_to_messages_in_room(self, pk, request_id, **kwargs):
        await self.message_activity.subscribe(room=pk, request_id=request_id)

    @model_observer(Message)
    async def message_activity(
        self,
        message,
        observer=None,
        subscribing_request_ids = [],
        **kwargs
    ):
        """
        This is evaluated once for each subscribed consumer.
        The result of `@message_activity.serializer` is provided here as the message.
        """
        # since we provide the request_id when subscribing we can just loop over them here.
        for request_id in subscribing_request_ids:
            message_body = dict(request_id=request_id)
            message_body.update(message)
            await self.send_json(message_body)

    @message_activity.groups_for_signal
    def message_activity(self, instance: Message, **kwargs):
        yield 'room__{instance.room_id}'
        yield f'pk__{instance.pk}'

    @message_activity.groups_for_consumer
    def message_activity(self, room=None, **kwargs):
        if room is not None:
            yield f'room__{room}'

    @message_activity.serializer
    def message_activity(self, instance:Message, action, **kwargs):
        """
        This is evaluated before the update is sent
        out to all the subscribing consumers.
        """
        return dict(data=MessageSerializer(instance).data, action=action.value, pk=instance.pk)

    async def notify_users(self):
        room: Room = await self.get_room(self.room_subscribe)
        for group in self.groups:
            await self.channel_layer.group_send(
                group,
                {
                    'type':'update_users',
                    'usuarios':await self.current_users(room)
                }
            )

    async def update_users(self, event: dict):
        await self.send(text_data=json.dumps({'usuarios': event["usuarios"]}))

    @database_sync_to_async
    def get_room(self, pk: int) -> Room:
        return Room.objects.get(pk=pk)

    @database_sync_to_async
    def current_users(self, room: Room):
        return [UserSerializers(user).data for user in room.current_users.all()]

    @database_sync_to_async
    def remove_user_from_room(self, room):
        user: User = self.scope["user"]
        user.current_rooms.remove(room)

    @database_sync_to_async
    def add_user_to_room(self, pk):
        user: User = self.scope["user"]
        if not user.current_rooms.filter(pk=self.room_subscribe).exists():
            user.current_rooms.add(Room.objects.get(pk=pk))