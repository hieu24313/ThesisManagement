from django.contrib import admin
from django.urls import path, include
from django.urls import path, include
from rest_framework import routers
# from ThesisManagementApp.ThesisManagement import views
from . import views

router = routers.DefaultRouter()
router.register('users', views.UserViewSet, basename='users')
router.register('criteria', views.CriteriaViewSet, basename='criteria')
router.register('committee', views.ThesisDefenseCommitteeViewSet, basename='committee')

urlpatterns = [
    path('', include(router.urls))
]