from django.urls import re_path
from rest_framework import routers

from . import consumers

router = routers.DefaultRouter()
router.register('chat/room', consumers.ChatConsumer, basename='chat-room')

websocket_urlpatterns = [
    re_path(r"ws/chat/(?P<room_name>\w+)/$", consumers.ChatConsumer.as_asgi()),
]