from django.urls import path
from rest_framework import routers

from . import views

urlpatterns = [
    path('', views.index, name="index"),
    path("<str:room_name>/", views.room, name="room"),
    # path("ws/<str:userId>/", views.room, name="room"),
]

