from django.core.exceptions import ObjectDoesNotExist
from django.db import transaction
from django.shortcuts import render
from rest_framework import viewsets, generics, status, permissions
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from . import serializers, paginators
from .mail import send_email
from .models import *
from django.http import JsonResponse
from oauth2_provider.decorators import protected_resource
from . import dao
from .permissions import IsAdmin, IsStudent, IsLecturer, IsUniversityAdministrator, IsAdminOrUniversityAdministrator
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from django.contrib.auth.hashers import make_password, check_password
from .tests import TestSendEmail


class BaseViewSet(viewsets.ModelViewSet):
    def perform_destroy(self, instance):
        # cập nhật trường 'active' thành False
        instance.active = False
        instance.save()


class GetUserViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAuthenticated]

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


class UpdateUserViewSet(viewsets.GenericViewSet, generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAuthenticated]

    # def filter_queryset(self, queryset):
    #     return dao.load_user(self.request.query_params)


class AddUserViewSet(viewsets.GenericViewSet, generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers
    permission_classes = [IsAuthenticated]


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
        return super().list(request, *args, **kwargs)


class AddCriteriaViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class UpdateCriteriaViewSet(viewsets.ViewSet, generics.RetrieveUpdateAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]


class GetThesisDefenseCommitteeViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        # TestSendEmail()
        return super().list(request, *args, **kwargs)

    def filter_queryset(self, queryset):
        return dao.load_committee(self.request.query_params)


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

    def filter_queryset(self, queryset):
        return dao.load_thesis(self.request.query_params)

    @swagger_auto_schema(manual_parameters=[
        openapi.Parameter('name', openapi.IN_QUERY, description="Lọc theo tên",
                          type=openapi.TYPE_STRING),
        openapi.Parameter('id', openapi.IN_QUERY, description='Tìm bằng id',
                          type=openapi.TYPE_STRING),
    ])
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)

    @action(detail=False, methods=['GET'])
    def status(self, request, pk=None):
        try:
            thesis = Thesis.objects.get(pk=pk)
        except Thesis.DoesNotExist:
            return Response({"detail": "Thesis not found"}, status=status.HTTP_404_NOT_FOUND)

        serializer = serializers.ThesisSerializers(thesis)

        return Response(serializer.data, status=status.HTTP_200_OK)


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
                        committee = ThesisDefenseCommittee.objects.get(pk=committee_id)
                        thesis = Thesis.objects.create(name=data.get('name'), committee=committee)
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
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)


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
    def partial_update(self, request, *args, **kwargs):
        thesis_id = kwargs.get('pk', None)

        try:
            thesis = Thesis.objects.get(pk=thesis_id)
        except ObjectDoesNotExist:
            return Response({'error': 'Không tìm thấy khóa luận!'}, status=status.HTTP_404_NOT_FOUND)

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

            thesis_students = ThesisStudent.objects.filter(thesis_id=thesis_id)
            thesis_students.delete()
            for s in svth_int:
                user = User.objects.get(id=s)
                ThesisStudent.objects.create(user=user, thesis=thesis)

        try:
            listgv = []
            giangvien1 = data.get('giangvien1')
            if giangvien1:
                giangvien1 = int(giangvien1)
                thesis_supervisor = ThesisSupervisor.objects.filter(thesis_id=thesis_id)
                thesis_supervisor.delete()
                gv1 = User.objects.get(pk=giangvien1)
                ThesisSupervisor.objects.create(user=gv1, thesis=thesis)
                listgv.append(gv1.email)
            giangvien2 = data.get('giangvien2')
            if giangvien2:
                giangvien2 = int(giangvien2)
                # thesis_supervisor2 = ThesisSupervisor.objects.filter(thesis_id=thesis_id)
                # thesis_supervisor2.delete()
                gv2 = User.objects.get(pk=giangvien2)
                ThesisSupervisor.objects.create(user=gv2, thesis=thesis)
                listgv.append(gv2.email)
            # gửi email thông báo
            send_email(listreceiver=listgv)
        except ValueError:
            return Response({'error': 'Mã Giảng Viên Không Hợp Lệ!!!'},
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


# viết lại các method từ đầu
class GetMemberOfThesisDefenseCommitteeViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = MemberOfThesisDefenseCommittee.objects.all()
    serializer_class = serializers.GetMemberOfThesisDefenseCommitteeSerializer

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


class GetScoreViewSet(viewsets.ReadOnlyModelViewSet, generics.ListAPIView):
    queryset = Score.objects.all()
    serializer_class = serializers.GetScoreSerializer

    def filter_queryset(self, queryset):
        return dao.load_score(self.request.query_params)


class AddScoreViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Score.objects.all()
    serializer_class = serializers.AddUpdateScoreSerializer
    permission_classes = [IsLecturer]


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


class OpenThesisViewSet(viewsets.ViewSet, generics.UpdateAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

    def partial_update(self, request, *args, **kwargs):
        status_thesis = StatusThesis.objects.get(pk=1)

        thesis_id = kwargs.get('pk')
        if thesis_id:
            try:
                thesis_id = int(thesis_id)
                thesis = Thesis.objects.get(pk=thesis_id)
                thesis.status = status_thesis
                thesis.save()
                return Response({'data': 'Thành Công!'}, status=status.HTTP_200_OK)
            except ValueError:
                return Response({'error': 'Sai Định Dạng Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'error': 'Thiếu Thông Tin Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)


class CloseThesisViewSet(viewsets.ViewSet, generics.UpdateAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers

    permission_classes = [IsAdminOrUniversityAdministrator]

    def partial_update(self, request, *args, **kwargs):
        status_thesis = StatusThesis.objects.get(pk=2)

        thesis_id = kwargs.get('pk')
        if thesis_id:
            try:
                thesis_id = int(thesis_id)
                thesis = Thesis.objects.get(pk=thesis_id)
                thesis.status = status_thesis
                thesis.save()
                return Response({'data': 'Thành Công!'}, status=status.HTTP_200_OK)
            except ValueError:
                return Response({'error': 'Sai Định Dạng Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'error': 'Thiếu Thông Tin Mã Khóa Luận!'}, status=status.HTTP_400_BAD_REQUEST)


def AddAllMember(committee, user_id, position_id):
    user = User.objects.get(pk=user_id)
    position = Position.objects.get(pk=position_id)
    MemberOfThesisDefenseCommittee.objects.create(user=user, Committee=committee, position=position)


class AddThesisDefenseCommitteeAndMemberViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

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
            if member1_id and position1_id:
                AddAllMember(committee, member1_id, position1_id)

            # member2
            member2_id = data.get('member2')
            position2_id = data.get('position2')
            if member2_id and position2_id:
                AddAllMember(committee, member2_id, position2_id)

            # member3
            member3_id = data.get('member3')
            position3_id = data.get('position3')
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
            return Response({'error': 'Có Lỗi Xảy Ra!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


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

