import json
from urllib.parse import urljoin

from django.contrib.auth.hashers import check_password
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404
from django.shortcuts import render, redirect
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action, api_view
from rest_framework.generics import ListAPIView
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView
from ThesisManagementApp import settings
from django.shortcuts import get_object_or_404
from django.shortcuts import render
from django.http import HttpResponse
from reportlab.pdfgen import canvas
from django.core.files.storage import default_storage
from django.conf import settings
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

from . import dao, paginators
from . import serializers
from .mail import send_email
from .models import *
from .permissions import IsLecturer, IsAdminOrUniversityAdministrator, IsAdmin, IsStudent
import random
import string
import base64
import os

# from .task import send_email_async


class BaseViewSet(viewsets.ModelViewSet):
    def perform_destroy(self, instance):
        # cập nhật trường 'active' thành False
        instance.active = False
        instance.save()


class GetUserViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    pagination_class = paginators.UserPagination

    # permission_classes = [IsAuthenticated]

    def filter_queryset(self, queryset):
        return dao.load_user(self.request.query_params)

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
        openapi.Parameter('username', openapi.IN_QUERY, description="Lọc theo username",
                          type=openapi.TYPE_STRING),
        openapi.Parameter('role', openapi.IN_QUERY, description="Lọc theo role (admin, universityadministrator, "
                                                                "lecturer, student)",
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)

    @action(methods=['get'], url_name='thesis', detail=True)
    def thesis(self, request, pk):
        list_stduent_thesis = ThesisStudent.objects.filter(user_id=pk)
        list_thesis = []
        for st in list_stduent_thesis:
            list_thesis.append(Thesis.objects.get(pk=st.thesis_id))

        return Response(serializers.ThesisSerializers(list_thesis, many=True, context={'request': request}).data,
                        status=status.HTTP_200_OK)

    @action(methods=['get'], url_name='committee', detail=True) #hội đồng user tham gia
    def committee(self, request, pk):
        committee = ThesisDefenseCommittee.objects.filter(memberofthesisdefensecommittee__user_id=pk)
        return Response(
            serializers.ThesisDefenseCommitteeSerializers(committee, many=True, context={'request': request}).data,
            status=status.HTTP_200_OK)

    @action(methods=['get'], url_name='score', detail=True) # lấy điểm của user
    def score(self, request, pk):
        params = request.query_params
        thesis = params.get('thesis')
        thesis_of_student = ThesisStudent.objects.get(user_id=pk, thesis_id=thesis)
        # list_score = []
        # for ts in thesis_of_student:
        #     ts.id
        list_score = Score.objects.filter(student_id=thesis_of_student.id, thesis_id=thesis)
        return Response(serializers.GetScoreSerializer(list_score, many=True, context={'request': request}).data,
                        status=status.HTTP_200_OK)


class UpdateUserViewSet(viewsets.GenericViewSet, generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAuthenticated]

    # def filter_queryset(self, queryset):
    #     return dao.load_user(self.request.query_params)


class AddUserViewSet(viewsets.GenericViewSet, generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAdmin]


class GetCriteriaViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers

    # permission_classes = [IsAuthenticated]

    def filter_queryset(self, queryset):
        return dao.load_criteria(self.request.query_params)

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        # Lấy thông tin người dùng hiện tại từ request
        # user = self.request.user

        # print('User Information:')
        # print('User ID:', user.id)
        # print('Username:', user.username)
        # print('Email:', user.email)

        return super().list(request, *args, **kwargs)


# class GetCriteriaViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
#     queryset = Criteria.objects.all()
#     serializer_class = serializers.CriteriaSerializers
#
#     permission_classes = [IsAuthenticated]
#
#     def filter_queryset(self, queryset):
#         return dao.load_criteria(self.request.query_params)
#
#     @swagger_auto_schema(manual_parameters=[
#         openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
#                           type=openapi.TYPE_STRING),
#     ])
#     def list(self, request, *args, **kwargs):
#         user = request.user
#         serializer = self.request.user
#         print('uuuuusssseeeerrr')
#         print(serializer)
#         # print(serializer.data)
#
#         return super().list(request, *args, **kwargs)


class AddCriteriaViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class UpdateCriteriaViewSet(viewsets.ViewSet, generics.RetrieveUpdateAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


def totalscore(thesis_id):
    print(thesis_id)
    students = ThesisStudent.objects.filter(thesis_id=thesis_id)  # danh sach sinh vien lam khoa luan thesis_id
    print(students)
    for s in students:
        print(s.id)
        scores_student = Score.objects.filter(thesis_id=thesis_id, student_id=s.id)  # danh sach diem cua sinh vien s
        print(scores_student)
        # cong thuc tinh diem : (diem * percent cua tieu chi do)/tong percent
        tong_diem = 0
        tong_tieu_chi = 0
        for score in scores_student:
            tong_diem += score.score * score.criteria.percent
            tong_tieu_chi += score.criteria.percent
            print('loai diem')
            print(score.criteria.percent)
            # criteria = Criteria.objects.get(score.criteria_id)
        if tong_tieu_chi == 0:
            s.total = 0
        else:
            s.total = round(tong_diem / tong_tieu_chi, 1)
        # print(s.total)
        s.save()


class GetThesisDefenseCommitteeViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers
    pagination_class = paginators.ThesisDefenseCommitteePagination

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        # TestSendEmail()
        return super().list(request, *args, **kwargs)

    def filter_queryset(self, queryset):
        return dao.load_committee(self.request.query_params)

    @action(methods=['get'], url_name='thesis', detail=True)
    def thesis(self, request, pk):
        list_thesis = Thesis.objects.filter(committee_id=pk)
        return Response(serializers.ThesisSerializers(list_thesis, many=True, context={'request': request}).data, status=status.HTTP_200_OK)

    @action(methods=['patch'], url_name='close', detail=True)
    def close(self, request, pk):
        list_thesis = Thesis.objects.filter(committee=pk)
        status_close = StatusThesis.objects.get(pk=2)
        committee = self.get_object()
        if committee.status != status_close:
            committee.status = status_close
            committee.save()
            list_send_email = []
            for thesis in list_thesis:
                totalscore(thesis.id)
                list_student = ThesisStudent.objects.filter(thesis=thesis)
                for student in list_student:
                    u = User.objects.get(pk=student.user_id)
                    list_send_email.append(u.email)
            send_email(subject="Khóa luận của bản đã được tổng kết điểm", body="Khóa luận của bản đã được tổng kết điểm", listreceiver=list_send_email)
            return Response('Thành công', status=status.HTTP_200_OK)
        else:
            return Response('Hội đồng này đã khóa!', status=status.HTTP_400_BAD_REQUEST)

    @action(methods='patch', detail=True, url_path='update-member', url_name='update-member')
    def update_member(self, request, pk):
        data = request.data
        # committee_id = data.get('committee')
        # if not committee_id:
        #     return Response({'error': 'Thiếu ID hội đồng!!!'}, status=status.HTTP_400_BAD_REQUEST)
        committee = self.get_object()
        # memberofcommittee = MemberOfThesisDefenseCommittee.objects.filter(Committee_id=committee_id)
        # memberofcommittee.delete()
        try:
            # member1
            member1_id = data.get('member1')
            position1_id = data.get('position1')

            if member1_id and position1_id:
                position1 = Position.objects.get(pk=position1_id)
                user = User.objects.get(pk=member1_id)
                try:
                    mem1 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position1)
                    mem1.user = user
                    mem1.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member1_id, position1_id)

            # member2
            member2_id = data.get('member2')
            position2_id = data.get('position2')

            if member2_id and position2_id:
                position2 = Position.objects.get(pk=position2_id)
                user = User.objects.get(pk=member2_id)
                try:
                    mem2 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position2)
                    mem2.user = user
                    mem2.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member2_id, position2_id)

            # member3
            member3_id = data.get('member3')
            position3_id = data.get('position3')

            if member3_id and position1_id:
                position3 = Position.objects.get(pk=position3_id)
                user = User.objects.get(pk=member3_id)
                try:
                    mem3 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position3)
                    mem3.user = user
                    mem3.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member3_id, position3_id)

            # member4
            member4_id = data.get('member4')
            position4_id = data.get('position4')

            if member4_id and position4_id:
                position4 = Position.objects.get(pk=position4_id)
                user = User.objects.get(pk=member4_id)
                try:
                    mem4 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position4)
                    mem4.user = user
                    mem4.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member4_id, position4_id)

            # member5
            member5_id = data.get('member5')
            position5_id = data.get('position5')
            if member5_id and position5_id:
                position5 = Position.objects.get(pk=position5_id)
                user = User.objects.get(pk=member5_id)
                try:
                    mem5 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position5)
                    mem5.user = user
                    mem5.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member5_id, position5_id)
            # if member1_id and position1_id:
            #     AddAllMember(committee, member1_id, position1_id)
            #
            # if member2_id and position2_id:
            #     AddAllMember(committee, member2_id, position2_id)
            #
            # if member3_id and position3_id:
            #     AddAllMember(committee, member3_id, position3_id)
            #
            # if member4_id and position4_id:
            #     AddAllMember(committee, member4_id, position4_id)
            #
            # if member5_id and position5_id:
            #     AddAllMember(committee, member5_id, position5_id)
            # super().create(request, *args, **kwargs)

            return Response({'data': serializers.ThesisDefenseCommitteeSerializers(committee).data},
                            status=status.HTTP_200_OK)
        except MemberOfThesisDefenseCommittee.DoesNotExist:
            return Response({'error': 'Check Lại ID Position và ID USER!'}, status=status.HTTP_400_BAD_REQUEST)


class AddThesisDefenseCommitteeViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class UpdateThesisDefenseCommitteeViewSet(viewsets.ViewSet, generics.RetrieveUpdateAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class GetThesisViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers
    permission_classes = [AllowAny]
    pagination_class = paginators.ThesisPagination

    def get_permissions(self):
        if self.action in ['lecturer', 'get_score_total_student', 'get_detail_score']:
            return [IsAuthenticated()]
        else:
            return [AllowAny()]

    def filter_queryset(self, queryset):
        return dao.load_thesis(self.request.query_params)

    @action(methods=['get'], url_path='score-total', url_name='score-total', detail=True)
    def get_score_total_student(self, request, pk):
        try:
            total = ThesisStudent.objects.get(user=request.user, thesis=self.get_object())
            return Response(serializers.ThesisStudentForScoreSerializers(total, context={'request': request}).data,
                        status=status.HTTP_200_OK)
        except ObjectDoesNotExist:
            return Response('Bạn không làm kháo luận này!!!', status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['get'], url_path='detail-score', url_name='detail-score', detail=True)
    def get_detail_score(self, request, pk):
        try:
            user_thesis_student = ThesisStudent.objects.get(user=request.user, thesis=self.get_object())
            score = Score.objects.filter(student=user_thesis_student, thesis=self.get_object())
            return Response(serializers.GetScoreSerializer(score, many=True, context={'request': request}).data,
                            status=status.HTTP_200_OK)
        except ValueError:
            return Response('Có lỗi xảy ra!', status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['patch'], url_name='update-name', url_path='update-name', detail=True)
    def update_name(self, request, pk):
        thesis = self.get_object()
        name = request.data.get('name')
        thesis.name = name
        thesis.save()
        return Response(serializers.ThesisSerializers(thesis, context={'request': request}).data,
                        status=status.HTTP_200_OK)

    @action(methods=['get'], url_name='lecturer', detail=False)
    def lecturer(self, request, pk=None):
        user = request.user
        if user.is_anonymous:
            return Response('Chưa đăng nhập!', status=status.HTTP_400_BAD_REQUEST)
        else:
            list_committee_user = list(MemberOfThesisDefenseCommittee.objects.filter(user=user))
            list_thesis = []
            for c in list_committee_user:
                print(c.Committee.status.name)
                # list_thesis.append(Thesis.objects.filter(status__name='Open', committee=c.Committee))
                if c.Committee.status.name == 'Open':
                    list_thesis += Thesis.objects.filter(committee=c.Committee)

            return Response(serializers.ThesisSerializers(list_thesis, many=True, context={'request': request}).data,
                            status=status.HTTP_200_OK)

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
        openapi.Parameter('id', openapi.IN_QUERY, description='Tìm bằng id',
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)

    # @action(detail=False, methods=['GET'])
    # def status(self, request, pk=None):
    #     try:
    #         thesis = Thesis.objects.get(pk=pk)
    #     except Thesis.DoesNotExist:
    #         return Response({"detail": "Thesis not found"}, status=status.HTTP_404_NOT_FOUND)
    #
    #     serializer = serializers.ThesisSerializers(thesis)
    #
    #     return Response(serializer.data, status=status.HTTP_200_OK)

    @action(methods=['GET'], url_name='score', detail=True)
    def score(self, request, pk):
        user = request.user
        if user.is_anonymous:
            print('no user')
            score = Score.objects.filter(thesis_id=pk)
            print(score)
            return Response(serializers.GetScoreSerializer(score, many=True, context={'request': request}).data,
                            status=status.HTTP_200_OK)
        else:
            print('co user')
            print(user)
            try:
                thesis = Thesis.objects.get(pk=pk)
                user_committee = MemberOfThesisDefenseCommittee.objects.get(Committee=thesis.committee, user=user)
                score = Score.objects.filter(thesis_id=pk, lecturer_id=user_committee.id)
                print(score)
            except ObjectDoesNotExist:
                return Response('Có dữ liệu chưa đầy đủ!!!', status=status.HTTP_400_BAD_REQUEST)

            return Response(serializers.GetScoreSerializer(score, many=True, context={'request': request}).data,
                            status=status.HTTP_200_OK)

    @action(methods=['GET'], url_name='student', detail=True)
    def student(self, request, pk):
        student = ThesisStudent.objects.filter(thesis_id=pk)
        return Response(serializers.ThesisStudentSerializers(student, many=True, context={'request': request}).data,
                        status=status.HTTP_200_OK)

    @action(methods='post', url_name='add-thesis', url_path='add-thesis', detail=False)
    def add_thesis(self, request):
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
            committee_id = data.get('committee')
            if committee_id:
                committee_id = int(committee_id)
                count_committee = Thesis.objects.filter(committee=committee_id).count()
                count_member = MemberOfThesisDefenseCommittee.objects.filter(Committee=committee_id).count()
                if 2 < count_member < 6:
                    if count_committee <= 5:
                        id_first_student = svth_int[0]
                        committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
                        student = User.objects.get(pk=id_first_student)
                        thesis = Thesis.objects.create(name=data.get('name'), committee=committee, major=student.major)
                    else:
                        return Response({'error': 'Hội Đồng Này Đã Được Phân Công Đủ 5 Khóa Luận!'},
                                        status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response({'error': 'Hội Đồng Này Chưa Đủ 3 Thành Viên!'},
                                    status=status.HTTP_400_BAD_REQUEST)

            else:
                thesis = self.get_object()

            for s in svth_int:
                user = User.objects.get(id=s)
                ThesisStudent.objects.create(user=user, thesis=thesis)

            try:
                listgv = []
                giangvien1 = data.get('giangvien1')
                if giangvien1:
                    giangvien1 = int(giangvien1)
                    gv1 = User.objects.get(pk=giangvien1)
                    ThesisSupervisor.objects.create(user=gv1, thesis=thesis)
                    listgv.append(gv1.email)
                giangvien2 = data.get('giangvien2')
                if giangvien2:
                    giangvien2 = int(giangvien2)
                    gv2 = User.objects.get(pk=giangvien2)
                    ThesisSupervisor.objects.create(user=gv2, thesis=thesis)
                    listgv.append(gv2.email)
                # gửi email thông báo
                send_email(listreceiver=listgv)
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
                            status=status.HTTP_400_BAD_REQUEST)

    @action(methods='PATCH', url_name='update-thesis', url_path='update-thesis', detail=True)
    def update_thesis(self, request, pk):

        thesis = self.get_object()  # khóa luận

        data = request.data

        committee_id_str = data.get('committee')
        if committee_id_str:
            try:
                committee_id = int(committee_id_str)
                committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
            except ObjectDoesNotExist:
                return Response({'error': 'Hội Đồng không tồn tại!'}, status=status.HTTP_404_NOT_FOUND)

            count_committee = Thesis.objects.filter(committee=committee_id).count()

            if count_committee <= 5:
                thesis.committee = committee
                thesis.save()
                # return Response({'success': 'Cập nhật thành công!'}, status=status.HTTP_200_OK)
            else:
                return Response({'error': 'Hội Đồng Này Đã Được Phân Công Đủ 5 Khóa Luận!'},
                                status=status.HTTP_400_BAD_REQUEST)

        # return Response({'error': 'Thiếu thông tin hội đồng!'}, status=status.HTTP_400_BAD_REQUEST)

        sv = data.get('sinhvien')  # idsv là chuỗi "1,3,5,6"
        if sv:
            svth_str = sv.split(',')  # kết quả sẽ là list ['1', '3', '5', '6']

            try:
                svth_int = [int(value) for value in svth_str]
            except ValueError:
                return Response({'error': 'Mã Sinh Viên Không Hợp Lệ!!!'},
                                status=status.HTTP_400_BAD_REQUEST)

            thesis_students = ThesisStudent.objects.filter(thesis=thesis)
            thesis_students.delete()
            for s in svth_int:
                user = User.objects.get(id=s)
                ThesisStudent.objects.create(user=user, thesis=thesis)

        try:
            # sua la ne ==============================================================
            listgv = []
            giangvien1 = data.get('giangvien1')
            if giangvien1:
                # giangvien1 = int(giangvien1)
                # thesis_supervisor = ThesisSupervisor.objects.filter(thesis=thesis, type='gv1')
                # thesis_supervisor.delete()
                lecturer1 = ThesisSupervisor.objects.filter(thesis=thesis, type='gv1')
                gv1 = User.objects.get(pk=giangvien1)
                lecturer1.user = gv1
                lecturer1.save()
                listgv.append(gv1.email)
            giangvien2 = data.get('giangvien2')
            if giangvien2:
                # giangvien2 = int(giangvien2)
                # thesis_supervisor2 = ThesisSupervisor.objects.filter(thesis_id=thesis_id)
                # thesis_supervisor2.delete()
                gv2 = User.objects.get(pk=giangvien2)
                # ThesisSupervisor.objects.create(user=gv2, thesis=thesis)
                lecturer2 = ThesisSupervisor.objects.filter(thesis=thesis, type='gv2')
                gv2 = User.objects.get(pk=giangvien2)
                lecturer2.user = gv2
                lecturer2.save()
                listgv.append(gv2.email)
            # gửi email thông báo
            send_email(listreceiver=listgv)
            return Response(serializers.ThesisSerializers(thesis).data, status=status.HTTP_201_CREATED)
        except User.DoesNotExist:
            return Response({'error': 'Mã Giảng Viên Không Tồn Tại!!!'},
                            status=status.HTTP_400_BAD_REQUEST)

        return Response({'data': 'Thành Công!!!'},
                        status=status.HTTP_200_OK)


class AddThesisViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

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
            committee_id = data.get('committee')
            if committee_id:
                committee_id = int(committee_id)
                count_committee = Thesis.objects.filter(committee=committee_id).count()
                count_member = MemberOfThesisDefenseCommittee.objects.filter(Committee=committee_id).count()
                if 2 < count_member < 6:
                    if count_committee <= 5:
                        id_first_student = svth_int[0]
                        committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
                        student = User.objects.get(pk=id_first_student)
                        thesis = Thesis.objects.create(name=data.get('name'), committee=committee, major=student.major)
                    else:
                        return Response({'error': 'Hội Đồng Này Đã Được Phân Công Đủ 5 Khóa Luận!'},
                                        status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response({'error': 'Hội Đồng Này Chưa Đủ 3 Thành Viên!'},
                                    status=status.HTTP_400_BAD_REQUEST)

            else:
                thesis = Thesis.objects.create(name=data.get('name'))

            for s in svth_int:
                user = User.objects.get(id=s)
                ThesisStudent.objects.create(user=user, thesis=thesis)

            try:
                listgv = []
                giangvien1 = data.get('giangvien1')
                if giangvien1:
                    giangvien1 = int(giangvien1)
                    gv1 = User.objects.get(pk=giangvien1)
                    ThesisSupervisor.objects.create(user=gv1, thesis=thesis, type='gv1')
                    listgv.append(gv1.email)
                giangvien2 = data.get('giangvien2')
                if giangvien2:
                    giangvien2 = int(giangvien2)
                    gv2 = User.objects.get(pk=giangvien2)
                    ThesisSupervisor.objects.create(user=gv2, thesis=thesis, type='gv1')
                    listgv.append(gv2.email)
                # gửi email thông báo
                send_email(listreceiver=listgv)
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
                            status=status.HTTP_400_BAD_REQUEST)


class UpdateThesisViewSet(viewsets.ViewSet, generics.RetrieveUpdateAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

    @swagger_auto_schema(request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING, description='Tên Khóa Luận'),
            'sinhvien': openapi.Schema(type=openapi.TYPE_STRING,
                                       description='Id những sinh viên thực hiện cách nhau dấu phẩy. VD: 1,3,5,6'),
            'giangvien1': openapi.Schema(type=openapi.TYPE_STRING, description='ID Giảng Viên Hướng Dẫn 1, lưu ý phải '
                                                                               'gửi cả id 2 khi update'),
            'giangvien2': openapi.Schema(type=openapi.TYPE_STRING, description='ID Giảng Viên Hướng Dẫn 2, lưu ý phải '
                                                                               'gửi key nếu k có gv 2 value bỏ trống'),
        },
        # required=['name', 'sinhvien', 'giangvien1', 'giangvien2']
    ))
    # def partial_update(self, request, *args, **kwargs):
    #     thesis_id = kwargs.get('pk', None)
    #
    #     try:
    #         thesis = Thesis.objects.get(pk=thesis_id)
    #     except ObjectDoesNotExist:
    #         return Response({'error': 'Không tìm thấy khóa luận!'}, status=status.HTTP_404_NOT_FOUND)
    #
    #     data = request.data
    #
    #     committee_id_str = data.get('committee')
    #     if committee_id_str:
    #         try:
    #             committee_id = int(committee_id_str)
    #             committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
    #         except ObjectDoesNotExist:
    #             return Response({'error': 'Hội Đồng không tồn tại!'}, status=status.HTTP_404_NOT_FOUND)
    #
    #         count_committee = Thesis.objects.filter(committee=committee_id).count()
    #
    #         if count_committee <= 5:
    #             thesis.committee = committee
    #             thesis.save()
    #             # return Response({'success': 'Cập nhật thành công!'}, status=status.HTTP_200_OK)
    #         else:
    #             return Response({'error': 'Hội Đồng Này Đã Được Phân Công Đủ 5 Khóa Luận!'},
    #                             status=status.HTTP_400_BAD_REQUEST)
    #
    #     # return Response({'error': 'Thiếu thông tin hội đồng!'}, status=status.HTTP_400_BAD_REQUEST)
    #
    #     sv = data.get('sinhvien')  # idsv là chuỗi "1,3,5,6"
    #     if sv:
    #         svth_str = sv.split(',')  # kết quả sẽ là list ['1', '3', '5', '6']
    #
    #         try:
    #             svth_int = [int(value) for value in svth_str]
    #         except ValueError:
    #             return Response({'error': 'Mã Sinh Viên Không Hợp Lệ!!!'},
    #                             status=status.HTTP_400_BAD_REQUEST)
    #
    #         thesis_students = ThesisStudent.objects.filter(thesis_id=thesis_id)
    #         thesis_students.delete()
    #         for s in svth_int:
    #             user = User.objects.get(id=s)
    #             ThesisStudent.objects.create(user=user, thesis=thesis)
    #
    #     try:
    #         #sua la ne ==============================================================
    #         listgv = []
    #         giangvien1 = data.get('giangvien1')
    #         if giangvien1:
    #             giangvien1 = int(giangvien1)
    #             thesis_supervisor = ThesisSupervisor.objects.filter(thesis_id=thesis_id)
    #             # thesis_supervisor.delete()
    #             gv1 = User.objects.get(pk=giangvien1)
    #             ThesisSupervisor.objects.create(user=gv1, thesis=thesis)
    #             listgv.append(gv1.email)
    #         giangvien2 = data.get('giangvien2')
    #         if giangvien2:
    #             giangvien2 = int(giangvien2)
    #             # thesis_supervisor2 = ThesisSupervisor.objects.filter(thesis_id=thesis_id)
    #             # thesis_supervisor2.delete()
    #             gv2 = User.objects.get(pk=giangvien2)
    #             ThesisSupervisor.objects.create(user=gv2, thesis=thesis)
    #             listgv.append(gv2.email)
    #         # gửi email thông báo
    #         send_email(listreceiver=listgv)
    #     except ValueError:
    #         return Response({'error': 'Mã Giảng Viên Không Hợp Lệ!!!'},
    #                         status=status.HTTP_400_BAD_REQUEST)
    #
    #     return Response({'data': 'Thành Công!!!'},
    #                     status=status.HTTP_200_OK)
    def partial_update(self, request, *args, **kwargs):
        thesis_id = kwargs.get('pk', None)

        try:
            thesis = Thesis.objects.get(pk=thesis_id)
        except ObjectDoesNotExist:
            return Response({'error': 'Không tìm thấy khóa luận!'}, status=status.HTTP_404_NOT_FOUND)

        # thesis = self.get_object()  # khóa luận

        data = request.data

        committee_id_str = data.get('committee')
        if committee_id_str:
            try:
                committee_id = int(committee_id_str)
                committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
            except ObjectDoesNotExist:
                return Response({'error': 'Hội Đồng không tồn tại!'}, status=status.HTTP_404_NOT_FOUND)

            count_committee = Thesis.objects.filter(committee=committee_id).count()

            if count_committee <= 5:
                thesis.committee = committee
                thesis.save()
                # return Response({'success': 'Cập nhật thành công!'}, status=status.HTTP_200_OK)
            else:
                return Response({'error': 'Hội Đồng Này Đã Được Phân Công Đủ 5 Khóa Luận!'},
                                status=status.HTTP_400_BAD_REQUEST)

        # return Response({'error': 'Thiếu thông tin hội đồng!'}, status=status.HTTP_400_BAD_REQUEST)

        sv = data.get('sinhvien')  # idsv là chuỗi "1,3,5,6"
        if sv:
            svth_str = sv.split(',')  # kết quả sẽ là list ['1', '3', '5', '6']

            try:
                svth_int = [int(value) for value in svth_str]
            except ValueError:
                return Response({'error': 'Mã Sinh Viên Không Hợp Lệ!!!'},
                                status=status.HTTP_400_BAD_REQUEST)

            thesis_students = ThesisStudent.objects.filter(thesis=thesis)
            thesis_students.delete()
            for s in svth_int:
                user = User.objects.get(id=s)
                ThesisStudent.objects.create(user=user, thesis=thesis)

        try:
            # sua lai ne ==============================================================
            listgv = []
            giangvien1 = data.get('giangvien1')
            if giangvien1:
                # print(giangvien1)
                # giangvien1 = int(giangvien1)
                # thesis_supervisor = ThesisSupervisor.objects.filter(thesis=thesis, type='gv1')
                # thesis_supervisor.delete()
                lecturer1 = ThesisSupervisor.objects.filter(thesis=thesis, type='gv1')
                gv1 = User.objects.get(pk=giangvien1)
                if lecturer1.count() > 0:

                    # print(gv1.id)
                    lecturer = lecturer1[0]
                    lecturer.user = gv1
                    lecturer.save()
                else:
                    ThesisSupervisor.objects.create(user=gv1, thesis=thesis, type=gv1)
                listgv.append(gv1.email)
            giangvien2 = data.get('giangvien2')
            if giangvien2:
                # giangvien2 = int(giangvien2)
                # thesis_supervisor2 = ThesisSupervisor.objects.filter(thesis_id=thesis_id)
                # thesis_supervisor2.delete()
                gv2 = User.objects.get(pk=giangvien2)
                # ThesisSupervisor.objects.create(user=gv2, thesis=thesis)
                lecturer2 = ThesisSupervisor.objects.filter(thesis=thesis, type='gv2')
                gv2 = User.objects.get(pk=giangvien2)
                if lecturer2.count() > 0:
                    lecturer = lecturer2[0]
                    lecturer.user = gv2
                    lecturer.save()
                else:
                    ThesisSupervisor.objects.create(user=gv2, thesis=thesis, type=gv2)
                listgv.append(gv2.email)
            # gửi email thông báo
            send_email(listreceiver=listgv)
            return super().partial_update(request, *args, **kwargs)
            # return Response(serializers.ThesisSerializers(thesis).data, status=status.HTTP_201_CREATED)
        except User.DoesNotExist:
            return Response({'error': 'Mã Giảng Viên Không Tồn Tại!!!'},
                            status=status.HTTP_400_BAD_REQUEST)

        return Response({'data': 'Thành Công!!!'},
                        status=status.HTTP_200_OK)


class GetUserByToken(viewsets.ViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        user = request.user
        serializer = self.serializer_class(user)
        return Response({'data': serializer.data},
                        status=status.HTTP_200_OK)


class GetPositionViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = Position.objects.all()
    serializer_class = serializers.PositionSerializers

    def list(self, request, *args, **kwargs):
        # send_email(listreceiver=['hieu24313@gmail.com'])
        # send_email_async.delay(subject='1111', message='2222', recipient_list=['hieu24313@gmail.com'])
        return super().list(request, *args, **kwargs)


# viết lại các method từ đầu
class GetMemberOfThesisDefenseCommitteeViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = MemberOfThesisDefenseCommittee.objects.all()
    serializer_class = serializers.GetMemberOfThesisDefenseCommitteeSerializer
    ordering_fields = ['position_id']

    def filter_queryset(self, queryset):
        return dao.load_member_of_committee(self.request.query_params)
    #
    # def create(self, request, *args, **kwargs):
    #     return super().create(request, *args, **kwargs)
    #
    # def partial_update(self, request, *args, **kwargs):
    #     return super().partial_update(request, *args, **kwargs)


class AddMemberOfThesisDefenseCommitteeViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = MemberOfThesisDefenseCommittee.objects.all()
    serializer_class = serializers.MemberOfThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class UpdateMemberOfThesisDefenseCommitteeViewSet(viewsets.ViewSet, generics.UpdateAPIView):
    queryset = MemberOfThesisDefenseCommittee.objects.all()
    serializer_class = serializers.MemberOfThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class DeleteMemberOfThesisDefenseCommitteeViewSet(viewsets.ViewSet, generics.DestroyAPIView):
    queryset = MemberOfThesisDefenseCommittee.objects.all()
    serializer_class = serializers.MemberOfThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

    def destroy(self, request, *args, **kwargs):
        member = self.get_object()
        committee = ThesisDefenseCommittee.objects.get(pk=member.Committee_id)
        if committee.status.name == 'Open':
            return super().destroy(request, *args, **kwargs)
        else:
            return Response('Hội động này đã được khóa! ')


class GetScoreViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = Score.objects.all()
    serializer_class = serializers.GetScoreSerializer

    def filter_queryset(self, queryset):
        return dao.load_score(self.request.query_params)


class AddScoreViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Score.objects.all()
    serializer_class = serializers.AddUpdateScoreSerializer
    permission_classes = [IsLecturer]

    def create(self, request, *args, **kwargs):
        # Lấy thông tin người dùng hiện tại từ request
        user = self.request.user
        # print('User Information:')
        # print('User ID:', user.id)
        # print('Username:', user.username)
        # print('Email:', user.email)
        data = request.data
        thesis = data.get('thesis')  # id khóa luận
        criteria = data.get('criteria')  # id tiêu chí
        lecturer = user.id  # id giảng viên
        print(user.id)
        student = data.get('student')  # id học sinh
        score_thesis = data.get('score')  # điểm được chấm của tiêu chí này
        if lecturer and student and thesis and criteria:
            student_user = ThesisStudent.objects.get(user_id=student,
                                                     thesis_id=thesis)  # lấy ra xem id của user đó trong bảng thesis student => lưu vào điểm
            try:
                thesis_user = Thesis.objects.get(pk=thesis)
                print(thesis_user.committee_id)
                # print('11wd')
                lecturer_user = MemberOfThesisDefenseCommittee.objects.get(user_id=lecturer,
                                                                           Committee_id=thesis_user.committee_id)  # id của gv trong bảng trung gian thesissupervisor
                try:
                    # print('toi day')
                    score = get_object_or_404(Score, lecturer_id=lecturer_user.id, student_id=student_user.id,
                                              criteria_id=criteria,
                                              thesis_id=thesis)
                    if score:
                        return Response({'error': 'Bạn đã chấm điểm cho tiêu chí này rồi!'},
                                        status=status.HTTP_400_BAD_REQUEST)
                    # print('toi day2')
                except Http404:
                    criteria_user = Criteria.objects.get(pk=criteria)
                    # member
                    new_score = Score.objects.create(score=score_thesis, lecturer=lecturer_user, student=student_user,
                                                     thesis=thesis_user, criteria=criteria_user, active=True)
                    return Response(serializers.GetScoreSerializer(new_score).data, status=status.HTTP_201_CREATED)
                    # super().create(request, *args, **kwargs)
            except MemberOfThesisDefenseCommittee.DoesNotExist:
                return Response('Bạn không có quyền chấm khóa luận này!!!', status=status.HTTP_400_BAD_REQUEST)

        else:
            return Response({'error': 'Gửi Thiếu Thông Tin Rồi Nhé!!'}, status=status.HTTP_400_BAD_REQUEST)


class UpdateScoreViewSet(viewsets.ViewSet, generics.UpdateAPIView):
    queryset = Score.objects.all()
    serializer_class = serializers.AddUpdateScoreSerializer

    permission_classes = [IsLecturer]

    def partial_update(self, request, *args, **kwargs):

        data = request.data

        thesis_id = data.get('thesis')

        if thesis_id:
            try:
                thesis_id = int(thesis_id)
                thesis = Thesis.objects.get(pk=thesis_id)
                try:
                    status_thesis = thesis.status.name
                except ValueError:
                    return Response({'error': 'Khóa Luận Không Tồn Tại!!'},
                                    status=status.HTTP_400_BAD_REQUEST)
                if status_thesis == 'Open':

                    # edit o day
                    return super().partial_update(request, *args, **kwargs)
                else:
                    return Response({'error': 'Khóa Luận Này Đã Đóng Không Thể Sửa Điểm!!'},
                                    status=status.HTTP_400_BAD_REQUEST)
            except ValueError:
                return Response({'error': 'Mã Khóa Luận Không Hợp Lệ!'},
                                status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'error': 'Thiếu Mã Khóa Luận!'},
                            status=status.HTTP_400_BAD_REQUEST)


# class OpenThesisViewSet(viewsets.ViewSet, generics.UpdateAPIView):
#     queryset = Thesis.objects.all()
#     serializer_class = serializers.ThesisSerializers
#
#     permission_classes = [IsAdminOrUniversityAdministrator]
#
#     def partial_update(self, request, *args, **kwargs):
#         status_thesis = StatusThesis.objects.get(pk=1)
#
#         thesis_id = kwargs.get('pk')
#         if thesis_id:
#             try:
#                 thesis_id = int(thesis_id)
#                 thesis = Thesis.objects.get(pk=thesis_id)
#                 thesis.status = status_thesis
#                 thesis.save()
#                 return Response({'data': 'Thành Công!'}, status=status.HTTP_200_OK)
#             except ValueError:
#                 return Response({'error': 'Sai Định Dạng Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)
#         else:
#             return Response({'error': 'Thiếu Thông Tin Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)


# class CloseThesisViewSet(viewsets.ViewSet, generics.UpdateAPIView):
#     queryset = Thesis.objects.all()
#     serializer_class = serializers.ThesisSerializers
#
#     permission_classes = [IsAdminOrUniversityAdministrator]
#
#     def partial_update(self, request, *args, **kwargs):
#         status_thesis = StatusThesis.objects.get(pk=2)
#         thesis_id = kwargs.get('pk')
#         if thesis_id:
#             try:
#                 thesis_id = int(thesis_id)
#                 thesis = Thesis.objects.get(pk=thesis_id)
#                 thesis.status = status_thesis
#                 thesis.save()
#                 student = ThesisStudent.objects.filter(thesis=thesis_id)
#                 listidsv = []
#                 listemail = []
#                 for s in student:
#                     listidsv.append(s.user_id)
#
#                 try:
#                     totalscore(thesis_id)  # tinh diem ne
#                 except ZeroDivisionError:
#                     return Response({'Có sinh viên chưa được chấm điểm'}, status=status.HTTP_400_BAD_REQUEST)
#                 for i in listidsv:
#                     user = User.objects.get(pk=i)
#                     listemail.append(user.email)
#
#                 send_email(subject='Khóa Luận Của Bạn Đã Được Chấm Điểm!', body='Khóa Luận Của Bạn Đã Được Chấm Điểm!',
#                            listreceiver=listemail)
#                 return Response({'data': 'Thành Công! Khóa Luận này Đã Được Đóng Lại!'}, status=status.HTTP_200_OK)
#             except ValueError:
#                 return Response({'error': 'Sai Định Dạng Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)
#         else:
#             return Response({'error': 'Thiếu Thông Tin Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)


# class CloseThesisViewSet(viewsets.ViewSet, generics.UpdateAPIView):
#     queryset = Thesis.objects.all()
#     serializer_class = serializers.ThesisSerializers
#
#     permission_classes = [IsAdminOrUniversityAdministrator]
#
#     def partial_update(self, request, *args, **kwargs):
#         status_thesis = StatusThesis.objects.get(pk=2)
#
#         thesis_id = kwargs.get('pk')
#         if thesis_id:
#             try:
#                 thesis_id = int(thesis_id)
#                 thesis = Thesis.objects.get(pk=thesis_id)
#                 thesis.status = status_thesis
#                 thesis.save()
#                 student = ThesisStudent.objects.filter(thesis=thesis_id)
#                 listidsv = []
#                 listemail = []
#                 for s in student:
#                     listidsv.append(s.user_id)
#
#                 async def background_task():
#                     await asyncio.sleep(5)  # đợi 5s nha
#                     for i in listidsv:
#                         user = User.objects.get(pk=i)
#                         listemail.append(user.email)
#                     send_email(subject='Khóa Luận Của Bạn Đã Được Chấm Điểm!',
#                                body='Khóa Luận Của Bạn Đã Được Chấm Điểm!',
#                                listreceiver=listemail)
#
#                 # Chuyển đổi hàm bất đồng bộ sang đồng bộ và chạy nó
#                 # return về rồi mưới chạy nó............
#                 async_to_sync(background_task)()
#
#                 return Response({'data': 'Thành Công!'}, status=status.HTTP_200_OK)
#             except ValueError:
#                 return Response({'error': 'Sai Định Dạng Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)
#         else:
#             return Response({'error': 'Thiếu Thông Tin Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)


def AddAllMember(committee, user_id, position_id):
    user = User.objects.get(pk=user_id)
    position = Position.objects.get(pk=position_id)
    MemberOfThesisDefenseCommittee.objects.create(user=user, Committee=committee, position=position, active=True)


class AddThesisDefenseCommitteeAndMemberViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.AddThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

    def create(self, request, *args, **kwargs):
        data = request.data
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        committee = serializer.instance  # Đối tượng vừa được tạo
        print(committee)
        try:
            # member1
            member1_id = data.get('member1')
            position1_id = data.get('position1')

            # member2
            member2_id = data.get('member2')
            position2_id = data.get('position2')

            # member3
            member3_id = data.get('member3')
            position3_id = data.get('position3')
            if member1_id and position1_id:
                AddAllMember(committee, member1_id, position1_id)

            if member2_id and position2_id:
                AddAllMember(committee, member2_id, position2_id)

            if member3_id and position3_id:
                AddAllMember(committee, member3_id, position3_id)

            # member4
            member4_id = data.get('member4')
            position4_id = data.get('position4')
            if member4_id and position4_id:
                AddAllMember(committee, member4_id, position4_id)

            # member4
            member5_id = data.get('member5')
            position5_id = data.get('position5')
            if member5_id and position5_id:
                AddAllMember(committee, member5_id, position5_id)
            # super().create(request, *args, **kwargs)
            return Response({'data': 'Thêm Thành Công!'}, status=status.HTTP_200_OK)
        except ValueError:
            return Response({'error': 'Có Lỗi Xảy Ra!'}, status=status.HTTP_400_BAD_REQUEST)


class UpdateThesisDefenseCommitteeAndMemberViewSet(viewsets.ViewSet, generics.UpdateAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

    def update(self, request, *args, **kwargs):
        data = request.data
        committee_id = data.get('committee')
        if not committee_id:
            return Response({'error': 'Thiếu ID hội đồng!!!'}, status=status.HTTP_400_BAD_REQUEST)
        committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
        # memberofcommittee = MemberOfThesisDefenseCommittee.objects.filter(Committee_id=committee_id)
        # memberofcommittee.delete()
        try:
            # member1
            member1_id = data.get('member1')
            position1_id = data.get('position1')

            if member1_id and position1_id:
                position1 = Position.objects.get(pk=position1_id)
                user = User.objects.get(pk=member1_id)
                try:
                    mem1 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position1)
                    mem1.user = user
                    mem1.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member1_id, position1_id)

            # member2
            member2_id = data.get('member2')
            position2_id = data.get('position2')

            if member2_id and position2_id:
                position2 = Position.objects.get(pk=position2_id)
                user = User.objects.get(pk=member2_id)
                try:
                    mem2 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position2)
                    mem2.user = user
                    mem2.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member2_id, position2_id)

            # member3
            member3_id = data.get('member3')
            position3_id = data.get('position3')

            if member3_id and position1_id:
                position3 = Position.objects.get(pk=position3_id)
                user = User.objects.get(pk=member3_id)
                try:
                    mem3 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position3)
                    mem3.user = user
                    mem3.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member3_id, position3_id)

            # member4
            member4_id = data.get('member4')
            position4_id = data.get('position4')

            if member4_id and position4_id:
                position4 = Position.objects.get(pk=position4_id)
                user = User.objects.get(pk=member4_id)
                try:
                    mem4 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position4)
                    mem4.user = user
                    mem4.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member4_id, position4_id)

            # member5
            member5_id = data.get('member5')
            position5_id = data.get('position5')
            if member5_id and position5_id:
                position5 = Position.objects.get(pk=position5_id)
                user = User.objects.get(pk=member5_id)
                try:
                    mem5 = MemberOfThesisDefenseCommittee.objects.get(Committee=committee, position=position5)
                    mem5.user = user
                    mem5.save()
                except MemberOfThesisDefenseCommittee.DoesNotExist:
                    AddAllMember(committee, member5_id, position5_id)
            # if member1_id and position1_id:
            #     AddAllMember(committee, member1_id, position1_id)
            #
            # if member2_id and position2_id:
            #     AddAllMember(committee, member2_id, position2_id)
            #
            # if member3_id and position3_id:
            #     AddAllMember(committee, member3_id, position3_id)
            #
            # if member4_id and position4_id:
            #     AddAllMember(committee, member4_id, position4_id)
            #
            # if member5_id and position5_id:
            #     AddAllMember(committee, member5_id, position5_id)
            # super().create(request, *args, **kwargs)

            return Response({'data': serializers.ThesisDefenseCommitteeSerializers(committee).data},
                            status=status.HTTP_200_OK)
        except MemberOfThesisDefenseCommittee.DoesNotExist:
            return Response({'error': 'Check Lại ID Position và ID USER!'}, status=status.HTTP_400_BAD_REQUEST)


class CheckPassWordViewSet(viewsets.ViewSet, generics.CreateAPIView):
    serializer_class = serializers.UserSerializers
    queryset = User.objects.all()
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        data = request.data

        user_id = data.get('user_id')
        old_password = data.get('old_password')

        # Kiểm tra xem người dùng có tồn tại không
        try:
            user = User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return Response({'error': 'Người dùng không tồn tại'}, status=status.HTTP_404_NOT_FOUND)

        # So sánh mật khẩu cũ
        is_password_correct = check_password(old_password, user.password)

        if is_password_correct:
            return Response({'data': True}, status=status.HTTP_200_OK)
        else:
            return Response({'error': False}, status=status.HTTP_400_BAD_REQUEST)


class GetMajorViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = Majors.objects.all()
    serializer_class = serializers.GetMajorSerializer

    def filter_queryset(self, queryset):
        server_domain = self.request.build_absolute_uri('/')[:-1]

        print(server_domain)

        return dao.load_major(self.request.query_params)


class ForgotPasswordViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers

    def create(self, request, *args, **kwargs):
        data = request.data
        email = data.get('email')
        if email:
            try:
                user = User.objects.get(email=email)
            except User.DoesNotExist:
                return Response({'error': 'Người dùng không tồn tại!'}, status=status.HTTP_400_BAD_REQUEST)
            characters = string.ascii_letters + string.digits
            password = ''.join(random.choice(characters) for _ in range(12))
            user.temp_password = password
            user.save()
            # mã hóa username
            username_encoded_text_bytes = base64.b64encode(user.username.encode('utf-8'))
            username = username_encoded_text_bytes.decode('utf-8')

            server_domain = self.request.build_absolute_uri('/')[:-1]
            # server_domain = settings.server_domain
            accept_new_password_url = urljoin(server_domain, f'/accept-new-password/?username={username}')

            body = (f'<h5>Bạn đã yêu cầu cấp mật khẩu mới!</h5>\n'
                    f'<h5>Tên Đăng Nhập: {user.username}\n</h5>'
                    f'<h5>Mật khẩu mới của bạn là: {password}\n</h5>'
                    f'<h5>Ấn vào liên kết sau để xác nhận mật khẩu mới: '
                    f'<a href="{accept_new_password_url}">Bấm vào đây!</a></h5>')
            list_email = [email]
            send_email(subject='Mật Khẩu Mới', body=body, listreceiver=list_email)

            return Response({'data': 'Vui lòng kiểm tra email để xác nhận mật khẩu mới!'}, status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Thiếu địa chỉ email rồi bạn ơi!'}, status=status.HTTP_400_BAD_REQUEST)


class AcceptNewPasswordViewSet(viewsets.ViewSet):

    def list(self, request, *args, **kwargs):
        username_encode = self.request.query_params.get('username')
        # param = request.GET.get('param', '')
        # select_option = request.GET.get('select_option', '')
        # select_option1 = request.GET.get('select_option1', '')
        # print(param)
        # print(select_option1)
        # print(select_option)
        # print('params o tren nhe')

        if username_encode:
            try:
                decoded_text_bytes = base64.b64decode(username_encode)
                username = decoded_text_bytes.decode('utf-8')
                user = User.objects.get(username=username)
                user.password = user.temp_password
                if user.temp_password:
                    user.temp_password = None
                    user.save()
                    msg = 'Mật khẩu của bạn đã được thay đổi!!!'
                    context = {
                        'msg': msg,
                    }
                    return render(request, 'acceiptpassword.html', context)
                else:
                    msg = 'Vào đây kiếm bug à? Không có đâu :))'
                    context = {
                        'msg': msg,
                    }
                    return render(request, 'acceiptpassword.html', context)
            except ObjectDoesNotExist:
                msg = 'Làm gì có ai có username này trong cơ sở dữ liệu đâu?'
                context = {
                    'msg': msg,
                }
                return render(request, 'acceiptpassword.html', context)
        else:
            msg = 'Thiếu username rồi nha, đừng sửa url của tui'
            context = {
                'msg': msg,
            }
            return render(request, 'acceiptpassword.html', context)


class AddOrUpdateManyScoreViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Score.objects.all()
    serializer_class = serializers.AddUpdateScoreSerializer

    permission_classes = [IsLecturer]

    def create(self, request, *args, **kwargs):

        data = request.data

        user_logging = request.user  # user cham diem
        print(user_logging)
        if user_logging.is_anonymous:
            print('111')
            return Response({'error': 'Không có quyền! Chưa đăng nhập!'}, status=status.HTTP_403_FORBIDDEN)
        score_json = data.get('score')
        score_data = json.loads(json.dumps(score_json))
        list_changed_score = []
        for item in score_data:
            student_id = item['student']
            criteria_id = item['criteria']
            thesis_id = item['thesis']
            score = item['score']
            thesis = Thesis.objects.get(pk=thesis_id)
            check = False
            if thesis:
                committee = ThesisDefenseCommittee.objects.get(pk=thesis.committee_id)
                if committee.status.name == 'Open':
                    check = True
                else:
                    check = False
            if check:
                # truy vấn các objects ở đây
                try:
                    student = ThesisStudent.objects.get(user_id=student_id, thesis_id=thesis_id)
                    criteria = Criteria.objects.get(pk=criteria_id)
                    lecturer = MemberOfThesisDefenseCommittee.objects.get(user_id=user_logging.id,
                                                                          Committee=thesis.committee)
                except ObjectDoesNotExist:
                    return Response('Không có quyền', status=status.HTTP_403_FORBIDDEN)
                try:
                    score_thesis = Score.objects.get(lecturer=lecturer, student=student, criteria=criteria,
                                                     thesis=thesis)
                    if score_thesis:
                        # update
                        score_thesis.score = score
                        score_thesis.save()
                        list_changed_score.append(score_thesis)
                except Score.DoesNotExist:
                    # add
                    score_thesis = Score.objects.create(lecturer=lecturer, score=score, student=student, thesis=thesis,
                                                        criteria=criteria)
                    list_changed_score.append(score_thesis)

            else:
                return Response({'error': 'Khóa luận này đã đóng và không được thay đổi điểm số!!'},
                                status=status.HTTP_400_BAD_REQUEST)
        return Response(serializers.GetScoreSerializer(list_changed_score, many=True).data, status=status.HTTP_200_OK)


# class TestSendArr(viewsets.ViewSet, generics.CreateAPIView):
#     queryset = Criteria.objects.all()
#     serializer_class = serializers.CriteriaSerializers
#
#     def create(self, request, *args, **kwargs):
#         arr = request.data.get('arr')  # đầu vào mẫu [{"a": 1,"b":2},{"a": 3,"b":4},{"a": 5,"b":6},{"a": 7,"b":8}]
#         data = json.loads(arr)  # phải dùng dấu 2 nháy "..."
#         print(data)
#
#         for item in data:
#             print(item["a"])
#             print(item["b"])
#
#         return Response('Ok', status=status.HTTP_200_OK)


# @api_view(['GET'])
class GetPDF(viewsets.ReadOnlyModelViewSet):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers

    @action(methods=['get'], detail=True, url_name='pdf', url_path='pdf')
    def pdf(self, request, pk):
        thesis_id = pk
        thesis = Thesis.objects.get(pk=thesis_id)
        response = HttpResponse(content_type='application/pdf')
        name_file = f'thesis{thesis.id}.pdf'

        response['Content-Disposition'] = f'attachment; filename="{name_file}"'
        # Tạo canvas để vẽ nội dung PDF
        # p = canvas.Canvas(response)
        file_path = default_storage.path(f'media/{name_file}')

        # Tạo canvas để vẽ nội dung PDF
        p = canvas.Canvas(file_path)

        # Thiết lập font và kích thước
        p.setFont("Helvetica-Bold", 12)
        # Tiêu đề
        p.setTitle(f'{thesis.name}')
        start_y_position = 800
        content_header_y_position = start_y_position - 20
        p.drawString(50, start_y_position, f'{thesis.name}')
        # p.drawString(50, content_header_y_position, "----")

        criteria = Criteria.objects.all()
        # print(len(criteria))
        # print(criteria)
        x_base = 500/(len(criteria) + 2)
        count = 3
        # print(x_base)
        p.drawString(x_base, 700, "ID")
        p.drawString(2 * x_base, 700, "Ho và Ten")
        for c in criteria:
            p.drawString(count * x_base, 700, f'{c.name}')
            count += 1
        data = []
        # Dữ liệu mẫu (đây có thể là dữ liệu từ cơ sở dữ liệu)
        thesis_student = ThesisStudent.objects.filter(thesis_id=thesis_id)
        for ts in thesis_student:
            obj = {}
            student = User.objects.get(pk=ts.user_id)
            student_ = ThesisStudent.objects.get(user=student, thesis=thesis)
            obj.update({"ID": ts.user_id, "Ho và Ten": f"{student.last_name} {student.first_name}"})
            for c in criteria:
                try:
                    score = Score.objects.filter(criteria=c, thesis_id=thesis_id, student=student_)
                    # print(score[0])
                    tong = 0
                    count1 = 0
                    for sc in score:
                        tong += sc.score
                        print(sc.score)
                        count1 += 1
                    if count1 == 0:
                        count1 = 1
                    obj.update({f"{c.name}": tong/count1})
                except ObjectDoesNotExist:
                    obj.update({f"{c.name}": "#"})
            data.append(obj)
            # print(student)
        # Vẽ dữ liệu từ mẫu vào PDF
        row_height = 20
        y_position = 680  # Điểm bắt đầu vẽ dữ liệu
        print(data)
        for item in data:
            count2 = 3
            p.drawString(x_base, y_position, str(item["ID"]))
            p.drawString(200, y_position, item["Ho và Ten"])
            for c in criteria:
                # p.drawString(x_base * count2, y_position, item[f"{c.name}"])
                p.drawString(x_base * count2, y_position, str(item[c.name]))
                count2 += 1

            y_position -= row_height

        # Kết thúc và trả về response
        p.showPage()
        p.save()
        file_url = default_storage.url(f'media/{name_file}')
        server_domain = request.META['HTTP_HOST']
        full_url = request.build_absolute_uri()
        # return JsonResponse({'pdf_url': f'{server_domain}/static{file_url}'})
        print(server_domain)
        return Response(f'http://{server_domain}/static{file_url}', status=status.HTTP_200_OK)
