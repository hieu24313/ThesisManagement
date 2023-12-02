from django.shortcuts import render
from rest_framework import viewsets, generics, status, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from . import serializers, paginators
# import serializers, paginators
from .models import User
from django.http import JsonResponse
from oauth2_provider.decorators import protected_resource


class UserViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    # permission_classes = [permissions.IsAuthenticated]
    # permission_classes = [permissions.IsAdminUser]

    @protected_resource()
    def my_protected_view(self, request):
        user = request.user
        user1 = self.request.user


