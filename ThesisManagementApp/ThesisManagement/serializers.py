from .models import User, Criteria
from rest_framework import serializers


class UserSerializers(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = '__all__'


class CriteriaSerializers(serializers.ModelSerializer):

    class Meta:
        model = Criteria
        fields = '__all__'

