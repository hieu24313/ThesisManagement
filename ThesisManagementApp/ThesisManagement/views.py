from django.shortcuts import render
from rest_framework import viewsets, generics, status, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from . import serializers, paginators
from .models import *
from django.http import JsonResponse
from oauth2_provider.decorators import protected_resource
from . import dao
from .permissions import IsAdmin


class UserViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializers

    def filter_queryset(self, queryset):
        return dao.load_user(self.request.query_params)


class CriteriaViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = Criteria.objects.all()
    serializer_class = serializers.CriteriaSerializers
    permission_classes = [IsAdmin]

    def filter_queryset(self, queryset):
        return dao.load_criteria(self.request.query_params)


class ThesisViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = Thesis.objects.all()
    serializer_class = serializers.ThesisSerializers


class ThesisDefenseCommitteeViewSet(viewsets.ModelViewSet, generics.ListAPIView):
    queryset = ThesisDefenseCommittee.objects.all()
    serializer_class = serializers.ThesisDefenseCommitteeSerializers

    def filter_queryset(self, queryset):
        return dao.load_committee(self.request.query_params)



