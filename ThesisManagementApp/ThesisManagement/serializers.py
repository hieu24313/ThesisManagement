from .models import *
from rest_framework import serializers


class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class CriteriaSerializers(serializers.ModelSerializer):
    class Meta:
        model = Criteria
        fields = '__all__'


class ThesisSerializers(serializers.ModelSerializer):
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
