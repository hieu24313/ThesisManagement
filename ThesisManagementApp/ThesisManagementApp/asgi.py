"""
ASGI config for ThesisManagementApp project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/howto/deployment/asgi/
"""

import os

from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
import django
from django.conf import settings
from channels.security.websocket import AllowedHostsOriginValidator
from chat.routing import websocket_urlpatterns

# django.setup()

from ThesisManagement import routing
# from djangochannelsrestframework.consumers import WebsocketDemultiplexer

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ThesisManagementApp.settings')

# application = ProtocolTypeRouter({
#     "http": get_asgi_application(),
#     "websocket": URLRouter(
#         routing.websocket_urlpatterns
#     ),
# })
# application = ProtocolTypeRouter({
#     "http": get_asgi_application(),
#     "websocket": AuthMiddlewareStack(
#         URLRouter(
#             routing.websocket_urlpatterns
#         )
#     ),
# })
django_asgi_app = get_asgi_application()

application = ProtocolTypeRouter(
    {
        "http": django_asgi_app,
        "websocket": AllowedHostsOriginValidator(
            AuthMiddlewareStack(URLRouter(websocket_urlpatterns))
        ),
    }
)