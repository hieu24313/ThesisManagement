from django.contrib import admin
from django.urls import path, include
from django.urls import path, include
from rest_framework import routers
# from ThesisManagementApp.ThesisManagement import views
from . import views

router = routers.DefaultRouter()
router.register('api/users', views.UserViewSet, basename='users')
router.register('api/criteria', views.CriteriaViewSet, basename='criteria')

urlpatterns = [
    path('', include(router.urls))
]