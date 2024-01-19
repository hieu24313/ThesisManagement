from django.core.asgi import get_asgi_application
from django.urls import re_path
from . import consumers

from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from django.urls import re_path
# from .consumers import RoomConsumer

# application = ProtocolTypeRouter({
#     "http": get_asgi_application(),
#     'websocket': AuthMiddlewareStack(
#         URLRouter(
#             [
#                 re_path(r'ws/room/(?P<pk>\d+)/$', RoomConsumer.as_asgi()),
#             ]
#         )
#     ),
# })

websocket_urlpatterns = [
    re_path(r'ws/chat/room/(?P<id_user>\w+)/$', consumers.ChatConsumer.as_asgi()),
    re_path(r'ws/$', consumers.RoomConsumer.as_asgi()),
    re_path(r'test/(?P<id_user>\w+)/$', consumers.RoomConsumer.as_asgi()),
]