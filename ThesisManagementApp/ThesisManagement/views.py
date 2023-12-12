from django.db import transaction
from django.shortcuts import render
from rest_framework import viewsets, generics, status, permissions
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from . import serializers, paginators
from .models import *
from django.http import JsonResponse
from oauth2_provider.decorators import protected_resource
from . import dao
from .permissions import IsAdmin, IsStudent, IsLecturer, IsUniversityAdministrator
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi

from .tests import TestSendEmail


class BaseViewSet(viewsets.ModelViewSet):
    def perform_destroy(self, instance):
        # cập nhật trường 'active' thành False
        instance.active = False
        instance.save()


class UserViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers

    def filter_queryset(self, queryset):
        return dao.load_user(self.request.query_params)


class CriteriaViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers

    # permission_classes = [IsAdmin]

    def filter_queryset(self, queryset):
        return dao.load_criteria(self.request.query_params)


class ThesisDefenseCommitteeViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        # TestSendEmail()
        return super().list(request, *args, **kwargs)

    @swagger_auto_schema(request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING, description='Tên Hội Đồng'),
        },
        required=['name']
    ))
    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)

    def filter_queryset(self, queryset):
        return dao.load_committee(self.request.query_params)


class ThesisViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers

    # permission_classes = [IsUniversityAdministrator]

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
        openapi.Parameter('id', openapi.IN_QUERY, description='Tìm bằng id',
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)

    @swagger_auto_schema(request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING, description='Tên Khóa Luận'),
            'sinhvien': openapi.Schema(type=openapi.TYPE_STRING,
                                       description='Id những sinh viên thực hiện các nhau dấu phẩy. VD: 1,3,5,6'),
            'giangvien1': openapi.Schema(type=openapi.TYPE_STRING, description='ID Giảng Viên Hướng Dẫn 1'),
            'giangvien2': openapi.Schema(type=openapi.TYPE_STRING, description='ID Giảng Viên Hướng Dẫn 2'),
        },
        required=['name', 'sinhvien', 'giangvien1', 'giangvien2']
    ))
    def create(self, request, *args, **kwargs):
        data = request.data
        # thesis = self.instance
        sv = data.get('sinhvien')  # idsv là chuỗi "1,3,5,6"
        svth_str = sv.split(',')  # kết quả sẽ là list ['1', '3', '5', '6']

        try:
            svth_int = [int(value) for value in svth_str]
        except ValueError:
            return Response({'error': 'Mã Sinh Viên Không Hợp Lệ!!!'},
                            status=status.HTTP_400_BAD_REQUEST)

        try:
            # with transaction.atomic():
            # Tạo đối tượng Khóa luận từ Serializer
            # serializer = self.get_serializer(data=data)
            # serializer.is_valid(raise_exception=True)
            thesis = Thesis.objects.create(name=data.get('name'))

            for s in svth_int:
                user = User.objects.get(id=s)
                ThesisStudent.objects.create(user=user, thesis=thesis)

            try:
                gv1 = ''
                gv2 = ''
                giangvien1 = data.get('giangvien1')
                if giangvien1:
                    giangvien1 = int(giangvien1)
                    gv1 = User.objects.get(pk=giangvien1)
                    ThesisSupervisor.objects.create(user=gv1, thesis=thesis)
                giangvien2 = data.get('giangvien2')
                if giangvien2:
                    giangvien2 = int(giangvien2)
                    gv2 = User.objects.get(pk=giangvien2)
                    ThesisSupervisor.objects.create(user=gv2, thesis=thesis)

            except ValueError:
                return Response({'error': 'Mã Giảng Viên Không Hợp Lệ!!!'},
                                status=status.HTTP_400_BAD_REQUEST)

            # Nếu mọi thứ ổn, commit
            # transaction.commit()

            return Response({'success': 'Thêm Thành Công.'}, status=status.HTTP_201_CREATED)
        except Exception as e:
            # Nếu có lỗi xảy ra, rollback
            # transaction.rollback()
            return Response({'error': f'Lỗi : {str(e)}'},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def filter_queryset(self, queryset):
        return dao.load_thesis(self.request.query_params)


class GetUserByToken(viewsets.ViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        user = request.user
        serializer = self.serializer_class(user)
        return Response({'data': serializer.data},
                        status=status.HTTP_200_OK)
