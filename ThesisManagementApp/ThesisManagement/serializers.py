from dataclasses import fields

from six import u

from .models import *
from rest_framework import serializers
from urllib.parse import urljoin


class GetMajorOnlyNameSerializer(serializers.ModelSerializer):

    class Meta:
        model = Majors
        fields = ['id', 'name']


class UserSerializers(serializers.ModelSerializer):
    major = GetMajorOnlyNameSerializer()

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

        if user.avatar and base_url not in urljoin(base_url, user.avatar.url):
            return user.avatar.url

    avatar_url = serializers.SerializerMethodField(method_name='get_image_url')


class MessageSerializer(serializers.ModelSerializer):
    created_at_formatted = serializers.SerializerMethodField()
    user = UserSerializers()

    class Meta:
        model = Message
        exclude = []
        depth = 1

    def get_created_at_formatted(self, obj:Message):
        return obj.created_at.strftime("%d-%m-%Y %H:%M:%S")


class RoomSerializer(serializers.ModelSerializer):
    last_message = serializers.SerializerMethodField()
    messages = MessageSerializer(many=True, read_only=True)

    class Meta:
        model = Room
        fields = ["pk", "name", "host", "messages", "current_users", "last_message"]
        depth = 1
        read_only_fields = ["messages", "last_message"]

    def get_last_message(self, obj:Room):
        return MessageSerializer(obj.messages.order_by('created_at').last()).data


class UserSerializersOnlyName(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'last_name', 'first_name', 'phone', 'email', 'role']


class CriteriaSerializers(serializers.ModelSerializer):
    class Meta:
        model = Criteria
        fields = ['id', 'name', 'percent']


class StatusThesisSerializers(serializers.ModelSerializer):
    class Meta:
        model = StatusThesis
        fields = ['id', 'name']


class ThesisSupervisorSerializers(serializers.ModelSerializer):
    user = UserSerializersOnlyName()

    class Meta:
        model = ThesisSupervisor
        fields = '__all__'


class ThesisStudentSerializers(serializers.ModelSerializer):
    user = UserSerializersOnlyName()

    class Meta:
        model = ThesisStudent
        fields = ['user']


class ThesisSerializersForScore(serializers.ModelSerializer):
    # status = StatusThesisSerializers()

    class Meta:
        model = Thesis
        fields = ['id', 'name']


class ThesisStudentForScoreSerializers(serializers.ModelSerializer):
    user = UserSerializersOnlyName()
    thesis = ThesisSerializersForScore()

    class Meta:
        model = ThesisStudent
        fields = '__all__'


class CommitteeSerializerOnlyName(serializers.ModelSerializer):
    status = StatusThesisSerializers()

    class Meta:
        model = ThesisDefenseCommittee
        fields = ['id', 'name', 'status']
        

class ThesisSerializers(serializers.ModelSerializer):
    # status = serializers.StringRelatedField(source='status.name')
    # student = ThesisStudentSerializers()
    # supervisor = ThesisSupervisorSerializers()
    committee = CommitteeSerializerOnlyName()
    students = ThesisStudentSerializers(source='thesisstudent_set', many=True)
    supervisors = ThesisSupervisorSerializers(source='thesissupervisor_set', many=True)

    class Meta:
        model = Thesis
        fields = '__all__'


# Hội đồng
class ThesisDefenseCommitteeSerializers(serializers.ModelSerializer):
    status = StatusThesisSerializers(allow_null=True)

    class Meta:
        model = ThesisDefenseCommittee
        fields = '__all__'


class AddThesisDefenseCommitteeSerializers(serializers.ModelSerializer):
    # status = StatusThesisSerializers(allow_null=True)

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
    status = StatusThesisSerializers()

    # thesis = ThesisSerializers()
    class Meta:
        model = ThesisDefenseCommittee
        fields = '__all__'


class PositionSerializerOnlyName(serializers.ModelSerializer):

    class Meta:
        model = Position
        fields = ['id', 'name']


class GetMemberOfThesisDefenseCommitteeSerializer(serializers.ModelSerializer):
    position = PositionSerializerOnlyName()
    user = UserSerializersOnlyName()
    Committee = CommitteeSerializerOnlyName()

    class Meta:
        model = MemberOfThesisDefenseCommittee
        fields = '__all__'


class GetMemberOfThesisDefenseCommitteeSerializersForScore(serializers.ModelSerializer):
    user = UserSerializersOnlyName()
    Committee = ThesisDefenseCommitteeSerializers()
    position = PositionSerializerOnlyName()

    class Meta:
        model = MemberOfThesisDefenseCommittee
        fields = ['user', 'Committee', 'position']


class GetScoreSerializer(serializers.ModelSerializer):
    lecturer = GetMemberOfThesisDefenseCommitteeSerializersForScore()
    student = ThesisStudentSerializers()
    thesis = ThesisSerializersForScore()
    criteria = CriteriaSerializers()

    class Meta:
        model = Score
        fields = '__all__'
#     class Meta:
#         model = Score
#         fields = ['score']


class AddUpdateScoreSerializer(serializers.ModelSerializer):

    class Meta:
        model = Score
        fields = '__all__'


class GetMajorSerializer(serializers.ModelSerializer):

    class Meta:
        model = Majors
        fields = '__all__'
