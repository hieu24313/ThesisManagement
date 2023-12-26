from dataclasses import fields

from six import u

from .models import *
from rest_framework import serializers


class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

        extra_kwargs = {
            'password': {
                'write_only': True
            }
        }

    # def get_image(self, user):
    #     request = self.context.get('request')
    #     if request:
    #         return request.build_absolute_uri('/static/%s' % user.image.name)
    #     return '/static/%s' % user.image.name

    def get_image_url(self, user):
        base_url = 'https://res.cloudinary.com/dyfzuigha/'
        # avatar_url = user.avatar.url
        if base_url not in user.avatar.url:
            # return avatar_url
            user.avatar = user.avatar.url

    avatar_url = serializers.SerializerMethodField(method_name='get_image_url')


class UserSerializersOnlyName(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'last_name', 'first_name', 'phone', 'email', 'role']


class CriteriaSerializers(serializers.ModelSerializer):
    class Meta:
        model = Criteria
        fields = '__all__'


class StatusThesisSerializers(serializers.ModelSerializer):
    class Meta:
        model = StatusThesis
        fields = '__all__'


class ThesisSupervisorSerializers(serializers.ModelSerializer):
    user = UserSerializersOnlyName()

    class Meta:
        model = ThesisSupervisor
        fields = '__all__'


class ThesisStudentSerializers(serializers.ModelSerializer):
    user = UserSerializersOnlyName()

    class Meta:
        model = ThesisStudent
        fields = '__all__'


class ThesisSerializers(serializers.ModelSerializer):
    # status = serializers.StringRelatedField(source='status.name')
    status = StatusThesisSerializers()
    # student = ThesisStudentSerializers()
    # supervisor = ThesisSupervisorSerializers()
    committee = serializers.CharField(required=False, allow_null=True)
    students = ThesisStudentSerializers(source='thesisstudent_set', many=True)
    supervisors = ThesisSupervisorSerializers(source='thesissupervisor_set', many=True)

    class Meta:
        model = Thesis
        fields = '__all__'


# Hội đồng
class ThesisDefenseCommitteeSerializers(serializers.ModelSerializer):
    class Meta:
        model = ThesisDefenseCommittee
        fields = '__all__'


# Bảng trung gian giữa hội đồng và khóa luận
class ThesisExaminationCommitteeSerializers(serializers.ModelSerializer):
    class Meta:
        model = ThesisExaminationCommittee
        fields = '__all__'


class PositionSerializers(serializers.ModelSerializer):
    class Meta:
        model = Position
        fields = '__all__'


class MemberOfThesisDefenseCommitteeSerializers(serializers.ModelSerializer):

    class Meta:
        model = MemberOfThesisDefenseCommittee
        fields = '__all__'


class ThesisDefenseCommitteeSerializersGETMember(serializers.ModelSerializer):
    # thesis = ThesisSerializers()
    class Meta:
        model = ThesisDefenseCommittee
        fields = '__all__'


class PositionSerializerOnlyName(serializers.ModelSerializer):

    class Meta:
        model = Position
        fields = ['id', 'name']


class CommitteeSerializerOnlyName(serializers.ModelSerializer):

    class Meta:
        model = ThesisDefenseCommittee
        fields = ['id', 'name']


class GetMemberOfThesisDefenseCommitteeSerializer(serializers.ModelSerializer):
    position = PositionSerializerOnlyName()
    user = UserSerializersOnlyName()
    Committee = CommitteeSerializerOnlyName()

    class Meta:
        model = MemberOfThesisDefenseCommittee
        fields = '__all__'
