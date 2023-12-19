from django.contrib import admin
from django.urls import path, include
from django.urls import path, include
from rest_framework import routers
# from ThesisManagementApp.ThesisManagement import views
from . import views

router = routers.DefaultRouter()
router.register('get-user-by-token', views.GetUserByToken, basename='get-user-by-token')
router.register('users', views.UserViewSet, basename='users')
router.register('criteria', views.CriteriaViewSet, basename='criteria')
router.register('committee', views.ThesisDefenseCommitteeViewSet, basename='committee')
router.register('thesis', views.ThesisViewSet, basename='thesis')
# router.register('get-member-of-committee', views.MemberOfThesisDefenseCommitteeViewSetGET,
#                 basename='get-member-of-committee')
router.register('add-update-member-of-committee', views.MemberOfThesisDefenseCommitteeViewSetPOSTAndPATCH,
                basename='add-update-member-of-committee')
router.register('position', views.PositionViewSet, basename='position')

urlpatterns = [
    path('', include(router.urls))
]