from django.shortcuts import render
from rest_framework import viewsets, generics, status, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from . import serializers, paginators
# import serializers, paginators
from .models import *
from django.http import JsonResponse
from oauth2_provider.decorators import protected_resource
from .dao import *
from .permissions import IsAdmin


class UserViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers

    def filter_queryset(self, queryset):
        load_user(self.request.QUERY_PARAMS)

    @protected_resource()
    def my_protected_view(self, request):
        pass
        # user = request.user
        # user1 = self.request.user


class CriteriaViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers
    permission_classes = [IsAdmin]

    def list(self, request, *args, **kwargs):
        # Kiểm tra quyền trước khi lấy danh sách người dùng
        if not IsAdmin:
            return Response(
                {"detail": "Bạn không có quyền truy cập tài nguyên này."},
                status=status.HTTP_403_FORBIDDEN
            )
        return super().list(request, *args, **kwargs)



