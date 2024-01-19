from django.contrib import admin
from django.shortcuts import redirect
from django.urls import path, include
from django.urls import path, include
from rest_framework import routers
# from ThesisManagementApp.ThesisManagement import views
from . import views, consumers

router = routers.DefaultRouter()
# router.register('swagger', views.swagger_redirect, basename='swagger')
router.register('get-user-by-token', views.GetUserByToken, basename='get-user-by-token')
router.register('get-users', views.GetUserViewSet, basename='get-users')
router.register('update-user', views.UpdateUserViewSet, basename='update-user')
router.register('add-user', views.AddUserViewSet, basename='add-user')
router.register('get-criteria', views.GetCriteriaViewSet, basename='get-criteria')
router.register('add-criteria', views.AddCriteriaViewSet, basename='add-criteria')
router.register('update-criteria', views.UpdateCriteriaViewSet, basename='update-criteria')
router.register('get-committee', views.GetThesisDefenseCommitteeViewSet, basename='get-committee')
router.register('add-committee', views.AddThesisDefenseCommitteeViewSet, basename='add-committee')
router.register('update-committee', views.UpdateThesisDefenseCommitteeViewSet, basename='update-committee')
router.register('get-thesis', views.GetThesisViewSet, basename='get-thesis')
router.register('add-thesis', views.AddThesisViewSet, basename='add-thesis')
router.register('update-thesis', views.UpdateThesisViewSet, basename='update-thesis')
router.register('get-position', views.GetPositionViewSet, basename='get-position')
router.register('get-member-of-committee', views.GetMemberOfThesisDefenseCommitteeViewSet,
                basename='get-member-of-committee')
router.register('add-member-of-committee', views.AddMemberOfThesisDefenseCommitteeViewSet,
                basename='add-member-of-committee')
router.register('update-member-of-committee', views.UpdateMemberOfThesisDefenseCommitteeViewSet,
                basename='update-member-of-committee')
router.register('delete-member-of-committee', views.DeleteMemberOfThesisDefenseCommitteeViewSet,
                basename='delete-member-of-committee')
router.register('get-score', views.GetScoreViewSet,
                basename='get-score')
router.register('add-score', views.AddScoreViewSet,
                basename='add-score')
router.register('update-score', views.UpdateScoreViewSet,
                basename='update-score')
router.register('open-thesis', views.OpenThesisViewSet,
                basename='open-thesis')
router.register('close-thesis', views.CloseThesisViewSet,
                basename='close-thesis')
router.register('add-all-member', views.AddThesisDefenseCommitteeAndMemberViewSet,
                basename='add-all-member')
router.register('check-old-password', views.CheckPassWordViewSet,
                basename='check-old-password')
router.register('get-major', views.GetMajorViewSet,
                basename='get-major')
router.register('forgot-password', views.ForgotPasswordViewSet, basename='forgot-password')
router.register('accept-new-password', views.AcceptNewPasswordViewSet, basename='accept-new-password')
router.register('update-committee-and-member', views.UpdateThesisDefenseCommitteeAndMemberViewSet,
                basename='update-committee-and-member')
router.register('add-or-update-score', views.AddOrUpdateManyScoreViewSet,
                basename='add-or-update-score')

# router.register('a', views.TestSendArr)
urlpatterns = [
    # path('swagger/', views.swagger_redirect, name='swagger'),
    path('', lambda _: redirect('/swagger/')),
    path('', include(router.urls)),
    # path('', include(websocket_urlpatterns))
]