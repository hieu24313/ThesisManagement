from .models import *
from rest_framework import serializers


class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


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
    # position = PositionSerializers()
    # user = UserSerializersOnlyName()
    # Committee = ThesisDefenseCommitteeSerializers()

    class Meta:
        model = MemberOfThesisDefenseCommittee
        fields = '__all__'


class ThesisDefenseCommitteeSerializersGETMember(serializers.ModelSerializer):
    # thesis = ThesisSerializers()
    class Meta:
        model = ThesisDefenseCommittee
        fields = '__all__'


class MemberOfThesisDefenseCommitteeSerializersForMethodGet(serializers.ModelSerializer):
    position = PositionSerializers()
    user = UserSerializersOnlyName()
    Committee = ThesisDefenseCommitteeSerializersGETMember()

    class Meta:
        model = MemberOfThesisDefenseCommittee
        fields = '__all__'

